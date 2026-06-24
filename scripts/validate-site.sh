#!/bin/sh
set -eu

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || fail "Missing required file: $1"
}

require_contains() {
  file="$1"
  pattern="$2"
  label="$3"
  grep -Eq "$pattern" "$file" || fail "$label not found in $file"
}

require_not_contains() {
  file="$1"
  pattern="$2"
  label="$3"
  if grep -Eq "$pattern" "$file"; then
    fail "$label found in $file"
  fi
}

require_file site/index.html
require_file site/robots.txt
require_file site/sitemap.xml

require_contains site/index.html '<link rel="canonical" href="https://ogedays.com/"' "Canonical URL"
require_contains site/index.html 'type="application/ld\+json"' "JSON-LD schema"
require_contains site/index.html 'mailto:iletisim@ogedays\.com' "Contact mailto link"
require_not_contains site/index.html '[[:space:]]disabled([[:space:]>]|=)' "Disabled interactive control"

require_contains site/robots.txt 'Sitemap: https://ogedays.com/sitemap.xml' "Robots sitemap reference"
require_contains site/sitemap.xml '<loc>https://ogedays.com/</loc>' "Sitemap homepage URL"

asset_refs=$(grep -oE '(src|href)="assets/[^"]+"' site/index.html | sed 's/.*="\([^"]*\)"/\1/' | sort -u || true)
for asset in $asset_refs; do
  require_file "site/$asset"
done

printf 'Static site validation passed.\n'


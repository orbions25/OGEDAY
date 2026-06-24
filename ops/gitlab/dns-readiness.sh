#!/bin/sh
set -eu

GITLAB_HOST="${GITLAB_HOST:-gitlab.ogedays.com}"
ROOT_DOMAIN="${ROOT_DOMAIN:-ogedays.com}"
FAIL_ON_MISSING_GITLAB="${FAIL_ON_MISSING_GITLAB:-0}"

resolve_host() {
  host="$1"
  if command -v getent >/dev/null 2>&1; then
    getent hosts "$host"
    return $?
  fi

  if command -v nslookup >/dev/null 2>&1; then
    nslookup "$host"
    return $?
  fi

  printf 'WARN: No getent or nslookup command is available.\n' >&2
  return 2
}

printf 'Checking root domain: %s\n' "$ROOT_DOMAIN"
if resolve_host "$ROOT_DOMAIN"; then
  printf 'Root domain resolves.\n'
else
  printf 'WARN: Root domain did not resolve from this machine.\n' >&2
fi

printf '\nChecking GitLab host: %s\n' "$GITLAB_HOST"
if resolve_host "$GITLAB_HOST"; then
  printf 'GitLab host resolves.\n'
else
  printf 'WARN: GitLab host does not resolve yet. Add an A or AAAA record before HTTPS install is considered ready.\n' >&2
  if [ "$FAIL_ON_MISSING_GITLAB" = "1" ]; then
    exit 1
  fi
fi

printf '\nDNS readiness check completed.\n'


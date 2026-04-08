#!/usr/bin/env bash
set -Eeuo pipefail

CRT_PATH="${1:-}"
CA_BUNDLE_PATH="${2:-}"

if [ -z "$CRT_PATH" ] || [ -z "$CA_BUNDLE_PATH" ]; then
  echo "Kullanim: sudo bash ops/install-ogedays-ssl.sh <crt_dosyasi> <ca_bundle_dosyasi>"
  exit 1
fi

SSL_DIR="/etc/ssl/ogedays"
NGINX_SITE="/etc/nginx/sites-available/ogedays.com"
NGINX_SSL_TEMPLATE="$(cd "$(dirname "$0")/nginx" && pwd)/ogedays.com.conf"

mkdir -p "$SSL_DIR"
cp "$CRT_PATH" "$SSL_DIR/ogedays.com.crt"
cp "$CA_BUNDLE_PATH" "$SSL_DIR/ogedays.com.ca-bundle"

test -f "$SSL_DIR/ogedays.com.key" || {
  echo "Private key bulunamadi: $SSL_DIR/ogedays.com.key"
  exit 1
}

cp "$NGINX_SSL_TEMPLATE" "$NGINX_SITE"
nginx -t
systemctl reload nginx

echo "OGEDAYS HTTPS yayini etkinlestirildi."

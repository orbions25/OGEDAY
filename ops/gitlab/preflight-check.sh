#!/bin/sh
set -eu

if [ -z "${GITLAB_EXTERNAL_URL:-}" ]; then
  printf 'ERROR: Set GITLAB_EXTERNAL_URL, for example https://gitlab.ogedays.com\n' >&2
  exit 1
fi

host=$(printf '%s\n' "$GITLAB_EXTERNAL_URL" | sed 's#^[a-zA-Z][a-zA-Z0-9+.-]*://##; s#/.*##; s#:.*##')

printf 'OGEDAY GitLab preflight for %s\n\n' "$GITLAB_EXTERNAL_URL"

printf 'Host: %s\n' "$host"
printf 'Kernel: '
uname -a

if command -v nproc >/dev/null 2>&1; then
  cpu_count=$(nproc)
  printf 'CPU count: %s\n' "$cpu_count"
  if [ "$cpu_count" -lt 8 ]; then
    printf 'WARN: GitLab single-node guidance recommends 8 vCPU for the standard small deployment target.\n'
  fi
fi

if command -v free >/dev/null 2>&1; then
  mem_mb=$(free -m | awk '/^Mem:/ { print $2 }')
  printf 'Memory MB: %s\n' "$mem_mb"
  if [ "$mem_mb" -lt 8192 ]; then
    printf 'WARN: Memory is below 8 GB; GitLab may be unstable or slow.\n'
  fi
fi

root_avail_kb=$(df -Pk / | awk 'NR == 2 { print $4 }')
root_avail_gb=$((root_avail_kb / 1024 / 1024))
printf 'Root available GB: %s\n' "$root_avail_gb"
if [ "$root_avail_gb" -lt 40 ]; then
  printf 'WARN: GitLab basic installation planning should allow at least 40 GB before repository data.\n'
fi

if command -v getent >/dev/null 2>&1; then
  if getent hosts "$host" >/dev/null 2>&1; then
    printf 'DNS lookup: ok\n'
  else
    printf 'WARN: DNS lookup failed for %s\n' "$host"
  fi
fi

printf '\nPort checks are intentionally not performed here because firewall policy may be provider-managed.\n'
printf 'Before install, confirm SSH 22, HTTP 80, and HTTPS 443 are intentionally allowed.\n'


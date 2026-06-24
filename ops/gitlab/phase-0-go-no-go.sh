#!/bin/sh
set -eu

GITLAB_HOST="${GITLAB_HOST:-gitlab.ogedays.com}"
STRICT="${STRICT:-0}"
decision_record="docs/gitlab/infrastructure-decision-record.md"
missing_count=0
open_count=0

require_file() {
  if [ ! -f "$1" ]; then
    printf 'WARN: Missing file: %s\n' "$1" >&2
    missing_count=$((missing_count + 1))
  fi
}

check_open_decision() {
  topic="$1"
  if [ -f "$decision_record" ] && grep -Fq "| $topic |  |" "$decision_record"; then
    printf 'WARN: Open decision: %s\n' "$topic" >&2
    open_count=$((open_count + 1))
  fi
}

require_file docs/gitlab/phase-0-readiness.md
require_file docs/gitlab/dns-and-tls-plan.md
require_file docs/gitlab/infrastructure-decision-record.md
require_file docs/gitlab/dns-change-request.md
require_file docs/gitlab/server-provisioning-checklist.md
require_file docs/gitlab/install-day-runbook.md
require_file docs/gitlab/phase-0-go-no-go.md
require_file docs/gitlab/github-fallback-plan.md

check_open_decision "DNS provider"
check_open_decision "GitLab server provider"
check_open_decision "GitLab server region"
check_open_decision "GitLab server size"
check_open_decision "Backup storage"
check_open_decision "Restore-test target"
check_open_decision "Runner machine"
check_open_decision "Software Admin owner"
check_open_decision "Supervisor owner"
check_open_decision "Emergency contact"
check_open_decision "GitHub fallback owner"

dns_ok=0
if command -v getent >/dev/null 2>&1 && getent hosts "$GITLAB_HOST" >/dev/null 2>&1; then
  dns_ok=1
elif command -v nslookup >/dev/null 2>&1 && nslookup "$GITLAB_HOST" >/dev/null 2>&1; then
  dns_ok=1
fi

printf 'Phase 0 Go/No-Go check\n'
printf 'GitLab host: %s\n' "$GITLAB_HOST"
printf 'DNS resolves: %s\n' "$dns_ok"

if [ "$dns_ok" != "1" ]; then
  printf 'WARN: %s does not resolve yet.\n' "$GITLAB_HOST" >&2
fi

if [ "$missing_count" -eq 0 ] && [ "$open_count" -eq 0 ] && [ "$dns_ok" = "1" ]; then
  printf 'Go to install: true\n'
else
  printf 'Go to install: false\n'
  if [ "$STRICT" = "1" ]; then
    exit 1
  fi
fi


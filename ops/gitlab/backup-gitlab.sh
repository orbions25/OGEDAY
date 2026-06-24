#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"

run() {
  if [ "$DRY_RUN" = "0" ]; then
    "$@"
  else
    printf '[dry-run] '
    printf '%s ' "$@"
    printf '\n'
  fi
}

run sudo gitlab-backup create
run sudo gitlab-ctl backup-etc

printf '\nManual verification after backup:\n'
printf '- Confirm the application backup exists under /var/opt/gitlab/backups.\n'
printf '- Confirm the configuration backup exists under /etc/gitlab/config_backup.\n'
printf '- Copy backups to the approved offsite storage.\n'
printf '- Never store gitlab-secrets.json in this repository.\n'


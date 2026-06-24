#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"

if [ -z "${BACKUP_ID:-}" ]; then
  printf 'ERROR: Set BACKUP_ID without the _gitlab_backup.tar suffix.\n' >&2
  printf 'Example: BACKUP_ID=1710000000_2026_06_24_18.0.0-ee\n' >&2
  exit 1
fi

run() {
  if [ "$DRY_RUN" = "0" ]; then
    "$@"
  else
    printf '[dry-run] '
    printf '%s ' "$@"
    printf '\n'
  fi
}

printf 'Preconditions before restore test:\n'
printf '- Use a clean test GitLab instance, not the live instance.\n'
printf '- The test instance must be the same GitLab version and type as the backup.\n'
printf '- Restore /etc/gitlab/gitlab-secrets.json and required configuration files securely.\n'
printf '- Confirm the backup tar exists in /var/opt/gitlab/backups.\n\n'

run sudo gitlab-ctl stop puma
run sudo gitlab-ctl stop sidekiq
run sudo gitlab-backup restore BACKUP="$BACKUP_ID"
run sudo gitlab-ctl reconfigure
run sudo gitlab-ctl restart
run sudo gitlab-rake gitlab:check SANITIZE=true

printf '\nPost-restore checks:\n'
printf '- Sign in with an admin account.\n'
printf '- Open the OGEDAY project.\n'
printf '- Confirm issues, merge requests, labels, CI variables, and runners state.\n'
printf '- Run a test pipeline on a non-production branch.\n'


#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"
GITLAB_PACKAGE="${GITLAB_PACKAGE:-gitlab-ee}"
GITLAB_REPO_SCRIPT="${GITLAB_REPO_SCRIPT:-https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh}"

if [ -z "${GITLAB_EXTERNAL_URL:-}" ]; then
  printf 'ERROR: Set GITLAB_EXTERNAL_URL, for example https://gitlab.ogedays.com\n' >&2
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

run sudo apt-get update
run sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

if command -v ufw >/dev/null 2>&1; then
  run sudo ufw allow 80/tcp
  run sudo ufw allow 443/tcp
  run sudo ufw limit 22/tcp
fi

run curl -fsSL "$GITLAB_REPO_SCRIPT" -o /tmp/gitlab-repository.deb.sh
run sudo bash /tmp/gitlab-repository.deb.sh
run sudo env EXTERNAL_URL="$GITLAB_EXTERNAL_URL" apt-get install -y "$GITLAB_PACKAGE"
run sudo gitlab-ctl status

printf '\nNext manual checks:\n'
printf '- Confirm DNS points to this server before using HTTPS.\n'
printf '- Sign in as root and rotate the initial password immediately.\n'
printf '- Apply ops/gitlab/gitlab.rb.example settings manually, then run sudo gitlab-ctl reconfigure.\n'
printf '- Do not make GitLab the only source of truth before backup and restore are tested.\n'


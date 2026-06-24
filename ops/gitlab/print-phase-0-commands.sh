#!/bin/sh
set -eu

GITLAB_EXTERNAL_URL="${GITLAB_EXTERNAL_URL:-https://gitlab.ogedays.com}"
GITLAB_HOST="${GITLAB_HOST:-gitlab.ogedays.com}"

printf 'OGEDAY GitLab Phase 0 command pack\n\n'
printf '1. DNS readiness\n'
printf 'FAIL_ON_MISSING_GITLAB=1 GITLAB_HOST="%s" sh ops/gitlab/dns-readiness.sh\n\n' "$GITLAB_HOST"
printf '2. Phase 0 go/no-go\n'
printf 'GITLAB_HOST="%s" sh ops/gitlab/phase-0-go-no-go.sh\n\n' "$GITLAB_HOST"
printf '3. Target server preflight, run on the GitLab server\n'
printf 'GITLAB_EXTERNAL_URL="%s" sh ops/gitlab/preflight-check.sh\n\n' "$GITLAB_EXTERNAL_URL"
printf '4. Install dry-run, run on the GitLab server\n'
printf 'GITLAB_EXTERNAL_URL="%s" sh ops/gitlab/install-single-node-ubuntu.sh\n\n' "$GITLAB_EXTERNAL_URL"
printf '5. Real install, only after go/no-go is approved\n'
printf 'DRY_RUN=0 GITLAB_EXTERNAL_URL="%s" sh ops/gitlab/install-single-node-ubuntu.sh\n' "$GITLAB_EXTERNAL_URL"


#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"
GITLAB_URL="${GITLAB_URL:-https://gitlab.ogedays.com}"
GITLAB_PROJECT_ID="${GITLAB_PROJECT_ID:-PROJECT_ID_OR_URL_ENCODED_PATH}"
BRANCH_NAME="${BRANCH_NAME:-main}"

if [ "$DRY_RUN" = "0" ] && [ -z "${GITLAB_TOKEN:-}" ]; then
  printf 'ERROR: Set GITLAB_TOKEN with Maintainer or Owner permission for the project.\n' >&2
  exit 1
fi

api_url="$GITLAB_URL/api/v4/projects/$GITLAB_PROJECT_ID/protected_branches"

if [ "$DRY_RUN" = "0" ]; then
  curl --request POST \
    --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    --data-urlencode "name=$BRANCH_NAME" \
    --data-urlencode "push_access_level=0" \
    --data-urlencode "merge_access_level=40" \
    --data-urlencode "unprotect_access_level=40" \
    --data-urlencode "allow_force_push=false" \
    "$api_url"
  printf '\n'
else
  printf '[dry-run] protect branch %s on %s\n' "$BRANCH_NAME" "$GITLAB_PROJECT_ID"
  printf '[dry-run] push_access_level=0 merge_access_level=40 unprotect_access_level=40 allow_force_push=false\n'
fi

printf 'Protected branch bootstrap completed.\n'


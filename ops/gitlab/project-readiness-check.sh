#!/bin/sh
set -eu

GITLAB_URL="${GITLAB_URL:-https://gitlab.ogedays.com}"
GITLAB_PROJECT_ID="${GITLAB_PROJECT_ID:-PROJECT_ID_OR_URL_ENCODED_PATH}"
BRANCH_NAME="${BRANCH_NAME:-main}"

if [ -z "${GITLAB_TOKEN:-}" ]; then
  printf 'ERROR: Set GITLAB_TOKEN with read access to the project.\n' >&2
  exit 1
fi

tmp_dir="${TMPDIR:-/tmp}/ogeday-gitlab-readiness"
mkdir -p "$tmp_dir"

api_get() {
  path="$1"
  out_file="$2"
  curl --silent --show-error --output "$out_file" --write-out '%{http_code}' \
    --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    "$GITLAB_URL/api/v4/$path"
}

project_status=$(api_get "projects/$GITLAB_PROJECT_ID" "$tmp_dir/project.json")
branch_status=$(api_get "projects/$GITLAB_PROJECT_ID/protected_branches/$BRANCH_NAME" "$tmp_dir/protected-branch.json")
labels_status=$(api_get "projects/$GITLAB_PROJECT_ID/labels?per_page=100" "$tmp_dir/labels.json")

printf 'Project API status: %s\n' "$project_status"
printf 'Protected branch API status: %s\n' "$branch_status"
printf 'Labels API status: %s\n' "$labels_status"

if [ "$project_status" != "200" ]; then
  printf 'ERROR: Project is not readable through the GitLab API.\n' >&2
  exit 1
fi

if [ "$branch_status" != "200" ]; then
  printf 'ERROR: Protected branch %s is not configured or not readable.\n' "$BRANCH_NAME" >&2
  exit 1
fi

if [ "$labels_status" != "200" ]; then
  printf 'ERROR: Project labels are not readable through the GitLab API.\n' >&2
  exit 1
fi

for label in 'type::task' 'type::access-request' 'risk::high' 'state::ready-for-release' 'access::production'; do
  if grep -Fq "\"$label\"" "$tmp_dir/labels.json"; then
    printf 'Label present: %s\n' "$label"
  else
    printf 'ERROR: Missing expected label: %s\n' "$label" >&2
    exit 1
  fi
done

printf 'Project readiness check passed.\n'


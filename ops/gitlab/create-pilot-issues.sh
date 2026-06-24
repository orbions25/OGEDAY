#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"
GITLAB_URL="${GITLAB_URL:-https://gitlab.ogedays.com}"
GITLAB_PROJECT_ID="${GITLAB_PROJECT_ID:-PROJECT_ID_OR_URL_ENCODED_PATH}"

if [ "$DRY_RUN" = "0" ] && [ -z "${GITLAB_TOKEN:-}" ]; then
  printf 'ERROR: Set GITLAB_TOKEN with permission to create project issues.\n' >&2
  exit 1
fi

api_url="$GITLAB_URL/api/v4/projects/$GITLAB_PROJECT_ID/issues"

create_issue() {
  title="$1"
  labels="$2"
  description="$3"

  if [ "$DRY_RUN" = "0" ]; then
    curl --request POST \
      --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
      --data-urlencode "title=$title" \
      --data-urlencode "labels=$labels" \
      --data-urlencode "description=$description" \
      "$api_url"
    printf '\n'
  else
    printf '[dry-run] create issue: %s\n' "$title"
    printf '[dry-run] labels: %s\n' "$labels"
  fi
}

task_description=$(cat <<'EOF'
## Objective

Complete the first task-driven GitLab workflow rehearsal for the OGEDAY website repository.

## Scope

- Create a small documentation-only branch.
- Open a merge request using the default MR template.
- Attach local validation evidence.
- Merge only after the pipeline passes.

## Acceptance criteria

- [ ] MR links back to this issue.
- [ ] Pipeline passes.
- [ ] Supervisor review checklist is complete.
- [ ] The team confirms the workflow is understandable.
EOF
)

qa_description=$(cat <<'EOF'
## Validation target

- Environment: GitLab pilot / website smoke test
- URL: https://ogedays.com/

## Checks

- [ ] Homepage loads.
- [ ] Main CTA mailto link works.
- [ ] Language switcher works.
- [ ] Mobile menu works.
- [ ] robots.txt is reachable.
- [ ] sitemap.xml is reachable.

## Evidence

Use docs/gitlab/release-evidence-format.md.
EOF
)

release_description=$(cat <<'EOF'
## Release target

Dry-run release rehearsal only. Do not deploy production changes from this issue.

## Checks

- [ ] Related MR is approved.
- [ ] Pipeline is green.
- [ ] QA Validation issue is approved.
- [ ] Rollback plan is documented.
- [ ] No production access is granted during this rehearsal.
EOF
)

access_description=$(cat <<'EOF'
## Request summary

This is a rehearsal-only access request. Do not grant production access from this issue.

## Purpose

Confirm that Supervisor review, Software Admin approval, expiry, and audit fields are understandable before the first real restricted access request.

## Expected outcome

- [ ] Supervisor review note is added.
- [ ] Software Admin decision is recorded.
- [ ] Permission remains ungranted.
- [ ] Audit register note is added.
EOF
)

create_issue 'Pilot Task: GitLab workflow rehearsal' 'type::task,area::docs,risk::low,state::needs-supervisor-review' "$task_description"
create_issue 'Pilot QA Validation: OGEDAY homepage smoke test' 'type::qa-validation,area::site,risk::low,state::ready-for-qa' "$qa_description"
create_issue 'Pilot Release Checklist: Dry-run release review' 'type::release,area::site,risk::low,state::ready-for-release' "$release_description"
create_issue 'Pilot Access Request: Rehearsal only' 'type::access-request,access::temporary,risk::medium,state::needs-admin-approval' "$access_description"

printf 'Pilot issue bootstrap completed.\n'


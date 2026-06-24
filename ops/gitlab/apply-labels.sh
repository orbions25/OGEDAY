#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"
GITLAB_URL="${GITLAB_URL:-https://gitlab.ogedays.com}"
GITLAB_PROJECT_ID="${GITLAB_PROJECT_ID:-PROJECT_ID_OR_URL_ENCODED_PATH}"

if [ "$DRY_RUN" = "0" ] && [ -z "${GITLAB_TOKEN:-}" ]; then
  printf 'ERROR: Set GITLAB_TOKEN with a token that can manage project labels.\n' >&2
  exit 1
fi

api_url="$GITLAB_URL/api/v4/projects/$GITLAB_PROJECT_ID/labels"

create_label() {
  name="$1"
  color="$2"
  description="$3"

  if [ "$DRY_RUN" = "0" ]; then
    curl --request POST \
      --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
      --data-urlencode "name=$name" \
      --data-urlencode "color=$color" \
      --data-urlencode "description=$description" \
      "$api_url"
    printf '\n'
  else
    printf '[dry-run] create label: %s | %s | %s\n' "$name" "$color" "$description"
  fi
}

create_label 'type::task' '#1F75CB' 'Normal planned implementation work'
create_label 'type::access-request' '#D99530' 'Temporary access request'
create_label 'type::qa-validation' '#00A36C' 'QA or release validation'
create_label 'type::release' '#5843AD' 'Release planning or deploy tracking'
create_label 'type::incident' '#D1242F' 'Production issue or emergency follow-up'

create_label 'area::site' '#0E8A16' 'HTML, assets, SEO, UI, and content'
create_label 'area::ops' '#5319E7' 'nginx, Docker, deploy, server, and TLS'
create_label 'area::gitlab' '#0052CC' 'CI, templates, CODEOWNERS, and project settings'
create_label 'area::docs' '#BFDADC' 'Runbooks, role matrix, and process docs'

create_label 'risk::low' '#C2E0C6' 'Documentation, copy, or safe content change'
create_label 'risk::medium' '#FBCA04' 'User-facing UI, routing, config, or behavior change'
create_label 'risk::high' '#B60205' 'Production, security, access, deploy, or data-impacting change'

create_label 'state::needs-supervisor-review' '#F9D0C4' 'Business or scope review is pending'
create_label 'state::needs-admin-approval' '#D4C5F9' 'Software Admin approval is pending'
create_label 'state::blocked' '#B60205' 'Work cannot continue without a decision or dependency'
create_label 'state::ready-for-qa' '#BFD4F2' 'Implementation is ready for QA validation'
create_label 'state::ready-for-release' '#C5DEF5' 'QA passed and release can be planned'

create_label 'access::temporary' '#D93F0B' 'Access must expire after a defined time'
create_label 'access::production' '#B60205' 'Production resource access'
create_label 'access::ci-secret' '#5319E7' 'CI variables, secrets, and deploy keys'
create_label 'access::server' '#D93F0B' 'SSH, nginx, Docker, and system service access'
create_label 'access::dns-tls' '#006B75' 'DNS, certificate, or TLS configuration'

printf 'Label bootstrap completed.\n'


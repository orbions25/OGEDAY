#!/bin/sh
set -eu

DRY_RUN="${DRY_RUN:-1}"
RUNNER_EXECUTOR="${RUNNER_EXECUTOR:-docker}"
RUNNER_DOCKER_IMAGE="${RUNNER_DOCKER_IMAGE:-alpine:3.20}"
RUNNER_DESCRIPTION="${RUNNER_DESCRIPTION:-ogeday-docker-runner}"

if [ -z "${GITLAB_URL:-}" ]; then
  printf 'ERROR: Set GITLAB_URL, for example https://gitlab.ogedays.com\n' >&2
  exit 1
fi

if [ -z "${RUNNER_AUTH_TOKEN:-}" ]; then
  printf 'ERROR: Set RUNNER_AUTH_TOKEN from GitLab runner creation UI. It should normally start with glrt-.\n' >&2
  exit 1
fi

if [ "$DRY_RUN" = "0" ] && [ "$RUNNER_EXECUTOR" = "docker" ] && ! command -v docker >/dev/null 2>&1; then
  printf 'ERROR: Docker executor selected but docker is not installed or not in PATH.\n' >&2
  printf 'Install Docker on the runner machine first, or set RUNNER_EXECUTOR=shell for a non-container runner.\n' >&2
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
run sudo apt-get install -y curl ca-certificates
run curl -fsSL https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh -o /tmp/gitlab-runner-repository.deb.sh
run sudo bash /tmp/gitlab-runner-repository.deb.sh
run sudo apt-get install -y gitlab-runner

if [ "$RUNNER_EXECUTOR" = "docker" ]; then
  run sudo gitlab-runner register \
    --non-interactive \
    --url "$GITLAB_URL" \
    --token "$RUNNER_AUTH_TOKEN" \
    --executor docker \
    --docker-image "$RUNNER_DOCKER_IMAGE" \
    --description "$RUNNER_DESCRIPTION"
else
  run sudo gitlab-runner register \
    --non-interactive \
    --url "$GITLAB_URL" \
    --token "$RUNNER_AUTH_TOKEN" \
    --executor "$RUNNER_EXECUTOR" \
    --description "$RUNNER_DESCRIPTION"
fi

run sudo gitlab-runner status

printf '\nNext manual checks:\n'
printf '- Confirm the runner appears online in GitLab.\n'
printf '- Keep deploy-capable runners restricted to protected branches.\n'
printf '- Run the OGEDAY pipeline before adding any deploy job.\n'

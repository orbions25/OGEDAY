# GitLab Group Bootstrap

Use this guide to create the initial self-hosted GitLab group structure.

## Top-level group

```text
OGEDAY
```

## Suggested subgroups

| Group | Purpose |
| --- | --- |
| `OGEDAY/software-admin` | Project settings, protected branches, runners, secrets, production access |
| `OGEDAY/supervisor` | Scope review, business approval, access justification |
| `OGEDAY/frontend` | Website and UI delivery |
| `OGEDAY/devops` | nginx, server, runner, deploy and backup operations |
| `OGEDAY/qa` | QA validation, release checks, post-deploy evidence |
| `OGEDAY/read-only` | Strategic visibility and reporting |

## CODEOWNERS replacement

After groups exist, replace placeholders in `CODEOWNERS`.

Example:

```text
* @OGEDAY/software-admin

site/ @OGEDAY/software-admin @OGEDAY/supervisor
ops/ @OGEDAY/software-admin
scripts/ @OGEDAY/software-admin
.gitlab/ @OGEDAY/software-admin @OGEDAY/supervisor
docs/gitlab/ @OGEDAY/software-admin @OGEDAY/supervisor
docker-compose.yml @OGEDAY/software-admin
```

## Permission baseline

- Software Admin: Maintainer or Owner depending on the GitLab group design.
- Supervisor: Developer or Maintainer, but not production secret owner by default.
- Frontend: Developer.
- DevOps: Developer or Maintainer by need.
- QA: Reporter or Developer.
- Read-only: Reporter.


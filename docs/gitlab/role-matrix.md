# OGEDAY GitLab Role Matrix

The exact GitLab usernames and groups must be decided during migration. This matrix defines the intended permission model.

| Role | GitLab target | Default access | Sensitive access | Notes |
| --- | --- | --- | --- | --- |
| CEO / Founder | Read-only group or Owner for strategic spaces | Read visibility to reports and release state | Approval by policy, not daily operational access | Keep visibility high but avoid unnecessary production permissions. |
| Software Admin | Maintainer / Owner | Full repository and project settings | Can grant temporary access | Owns runners, protected branches, deploy keys, CI variables, and recovery. |
| Supervisor | Developer or Maintainer depending on team size | Review issues, MRs, and scope | Can approve business need, not grant technical access alone | Owns process quality and access justification. |
| Frontend Developer | Developer | Work on `site/` changes through MR | Needs request for production deploy or nginx/TLS access | Cannot push directly to protected branch. |
| Backend / DevOps Developer | Developer or Maintainer by need | Work on `ops/`, scripts, and deployment changes through MR | Needs request for production server, runner, or secret access | Sensitive changes require Software Admin approval. |
| QA / Test | Reporter or Developer | Validate issues, MRs, and releases | No default production access | Adds release evidence and blocks unsafe deploys. |

## Recommended group placeholders

Replace these placeholders in `CODEOWNERS` after GitLab groups are created:

| Placeholder | Intended real group |
| --- | --- |
| `@software-admin` | OGEDAY Software Admin group |
| `@supervisor` | OGEDAY Supervisor group |

## Need-to-know defaults

- Repository read access should not imply production access.
- Production access should be temporary by default.
- CI variables and deploy keys should be Software Admin owned.
- DNS, TLS, and nginx access should require Access Request approval.
- Emergency access should be documented after the fact if pre-approval is impossible.


# OGEDAY GitLab Labels

Use a small label system at the beginning. The goal is to make work visible without turning GitLab into bureaucracy.

## Type labels

| Label | Use |
| --- | --- |
| `type::task` | Normal planned implementation work |
| `type::access-request` | Temporary access request |
| `type::qa-validation` | QA or release validation |
| `type::release` | Release planning or deploy tracking |
| `type::incident` | Production issue or emergency follow-up |

## Area labels

| Label | Use |
| --- | --- |
| `area::site` | `site/` HTML, assets, SEO, UI, content |
| `area::ops` | nginx, Docker, deploy, server, TLS |
| `area::gitlab` | CI, templates, CODEOWNERS, project settings |
| `area::docs` | Runbooks, role matrix, process docs |

## Risk labels

| Label | Use |
| --- | --- |
| `risk::low` | Documentation, copy, or safe content change |
| `risk::medium` | User-facing UI, routing, config, or behavior change |
| `risk::high` | Production, security, access, deploy, or data-impacting change |

## State labels

| Label | Use |
| --- | --- |
| `state::needs-supervisor-review` | Business or scope review is pending |
| `state::needs-admin-approval` | Software Admin approval is pending |
| `state::blocked` | Work cannot continue without a decision or dependency |
| `state::ready-for-qa` | Implementation is ready for QA validation |
| `state::ready-for-release` | QA passed and release can be planned |

## Access labels

| Label | Use |
| --- | --- |
| `access::temporary` | Access must expire after a defined time |
| `access::production` | Production resource access |
| `access::ci-secret` | CI variables, secrets, deploy keys |
| `access::server` | SSH, nginx, Docker, system service access |
| `access::dns-tls` | DNS, certificate, or TLS configuration |

## Suggested issue boards

Start with four boards:

- Delivery: Open, In Progress, Ready for QA, Ready for Release, Done
- Access: Requested, Supervisor Reviewed, Admin Approved, Granted, Removed
- QA: Waiting, Running, Blocked, Approved
- Release: Planned, Deploying, Validating, Released, Rolled Back


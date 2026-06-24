# OGEDAY Audit Register

This file is a lightweight register format for the first 6-7 months of GitLab operational observation. It should not replace GitLab audit logs, but it gives the team a human-readable summary of important events.

## What to record

- Production deploys
- Rollbacks
- Emergency fixes
- Permission grants
- Permission removals
- CI/CD variable changes
- Runner changes
- Protected branch changes
- DNS, TLS, nginx, or server changes

## Entry format

```md
## YYYY-MM-DD - Short event title

- Category:
- Related issue:
- Related merge request:
- Actor:
- Approver:
- Resource:
- Access duration:
- Action taken:
- Validation evidence:
- Follow-up:
```

## Review rhythm

- Review new audit entries weekly.
- Summarize repeated access requests monthly.
- Convert repeated manual approvals into clearer policy.
- Convert repeated validation steps into CI checks only after they are stable.

## Open register

Add entries below this line during the GitLab pilot.


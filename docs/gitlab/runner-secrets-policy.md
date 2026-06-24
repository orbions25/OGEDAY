# OGEDAY Runner and Secrets Policy

This policy defines how GitLab runners, CI variables, deploy keys, and production credentials should be handled during the self-hosted GitLab migration.

## Runner defaults

- Use dedicated runners for OGEDAY projects.
- Do not share production deploy runners with untrusted or experimental projects.
- Restrict deploy-capable runners to protected branches.
- Keep runner registration tokens under Software Admin control.
- Review runner logs after pipeline failures that touch deploy or secret paths.

## CI variables

- Store production secrets as masked variables where possible.
- Mark production variables as protected.
- Do not expose production variables to merge request pipelines from untrusted branches.
- Rotate variables after emergency access or suspected exposure.
- Never write secrets to repository files, issue descriptions, MR comments, screenshots, or logs.

## Deploy keys and SSH

- Deploy keys should be scoped to the minimum repository or server access needed.
- SSH keys for production deploy must have an owner and rotation plan.
- Any manual use of production SSH access should have an Access Request issue.
- Emergency SSH access must be documented in an Incident Report after the fact.

## Separation of duties

- Developers can request production access.
- Supervisors can validate business need and scope.
- Software Admin grants and removes technical access.
- QA validates release outcome but does not need default production access.

## Rotation triggers

Rotate or revoke credentials when:

- A person leaves the project.
- A device is lost or compromised.
- A CI log may have exposed sensitive data.
- Emergency access was used.
- A deploy key was copied outside the approved environment.
- A runner was reconfigured unexpectedly.


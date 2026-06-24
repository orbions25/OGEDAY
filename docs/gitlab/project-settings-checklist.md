# OGEDAY GitLab Project Settings Checklist

Use this checklist immediately after importing the repository into self-hosted GitLab.

## Repository

- [ ] Default branch is `main`.
- [ ] Direct push to `main` is disabled.
- [ ] Force push to protected branches is disabled.
- [ ] Merge requests are required for `main`.
- [ ] Stale approvals are dismissed when new commits are pushed.
- [ ] CODEOWNERS approval is enabled for protected branches.

## Merge requests

- [ ] Merge request template is enabled.
- [ ] Pipeline must pass before merge.
- [ ] Discussions must be resolved before merge.
- [ ] Squash policy is decided by the team.
- [ ] Delete source branch after merge is enabled, unless release branches are used.

## CI/CD

- [ ] Runner is registered and tagged.
- [ ] Runner access is limited to trusted projects.
- [ ] CI variables are masked and protected where possible.
- [ ] Production deploy variables are available only on protected branches.
- [ ] Pipeline logs do not expose secrets.

## Security and access

- [ ] Real GitLab groups replace placeholder `CODEOWNERS` entries.
- [ ] Software Admin group owns project settings.
- [ ] Supervisor group can review scope and access requests.
- [ ] Developers cannot grant themselves production access.
- [ ] Temporary access requests use expiry dates.
- [ ] Emergency access is documented after use.

## Operations

- [ ] Backup schedule is configured.
- [ ] Restore process is tested.
- [ ] Release Checklist issue template is used before production deploy.
- [ ] QA Validation issue template is used for release checks.
- [ ] Monthly governance report process is assigned.


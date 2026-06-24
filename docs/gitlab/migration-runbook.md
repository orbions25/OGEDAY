# OGEDAY GitLab Migration Runbook

This runbook describes how to apply the self-hosted GitLab model to the current OGEDAY website repository without disrupting the live `ogedays.com` site.

## Phase 0 - Decisions before migration

- Decide the GitLab domain and hosting target.
- Use `docs/gitlab/phase-0-readiness.md` as the readiness gate.
- Record decisions in `docs/gitlab/infrastructure-decision-record.md`.
- Use `docs/gitlab/dns-and-tls-plan.md` for DNS and HTTPS preparation.
- Decide whether the initial GitLab server is single-node or prepared for later scaling.
- Decide real GitLab groups for Software Admin, Supervisor, Developer, QA, and Read-only visibility.
- Decide backup storage location and retention policy.
- Decide who can approve production access.
- Decide the first restore-test date before GitLab becomes the only source of truth.
- Review `ops/gitlab/source-links.md` for the official GitLab docs used by this repo.
- Use `docs/gitlab/pilot-execution-plan.md` as the first-week execution tracker.

## Phase 1A - GitLab Core

- Install GitLab.
- Run `ops/gitlab/preflight-check.sh` before installation.
- Use `ops/gitlab/install-single-node-ubuntu.sh` as the reviewed command guide.
- Enable HTTPS.
- Create the OGEDAY group.
- Import or mirror this repository.
- Use `ops/gitlab/import-ogeday-repo.md` for the import checklist.
- Create real GitLab groups that replace the placeholder `CODEOWNERS` entries.
- Use `ops/gitlab/bootstrap-groups.md` for the first group layout.
- Protect `main`.
- Use `ops/gitlab/api-bootstrap.md` for label creation and `main` branch protection helpers.
- Disable direct push to `main`.
- Enable merge request pipeline requirements.
- Configure runner capacity for static validation jobs.
- Use `ops/gitlab/install-runner-ubuntu.sh` on a separate runner machine after a runner authentication token is created in GitLab.
- Apply runner and secret rules from `docs/gitlab/runner-secrets-policy.md`.
- Prepare backup and restore checks from `docs/gitlab/backup-restore-checklist.md`.
- Use `ops/gitlab/backup-gitlab.sh` and `ops/gitlab/restore-test-checklist.sh` as reviewed command guides.

## Phase 1B - Operational Discipline

- Enable issue templates.
- Enable merge request templates.
- Require a linked issue for every merge request.
- Use Access Request issues for restricted resources.
- Use QA Validation issues for release checks.
- Use Release Checklist issues before production deploys.
- Use Incident Report issues for emergency fixes and production failures.
- Add CODEOWNERS approval for `ops/`, `.gitlab/`, `scripts/`, and deploy files.
- Create labels from `docs/gitlab/labels.md`.
- Apply project settings from `docs/gitlab/project-settings-checklist.md`.

## Phase 1C - Website pilot

Use this OGEDAY website repo as the first pilot because it is small, visible, and low-risk compared with larger application repositories.

Pilot checks:

- CI validates `site/index.html`, `robots.txt`, and `sitemap.xml`.
- CI validates required governance templates.
- MR template is used for every change.
- QA Validation issue is created before production deploy.
- Access Request issue is created for nginx, TLS, server, or runner access.

## Phase 2 - Internal governance

- Add issue boards for Task, Access Request, QA Validation, and Release.
- Add labels for risk, area, access, release, and blocked state.
- Review audit history weekly.
- Keep `docs/gitlab/audit-register.md` as the first lightweight human-readable register.
- Build a short monthly governance report from issues, MRs, and pipeline data.
- Use `docs/gitlab/monthly-governance-report-template.md` for the first 6-7 months.

## Phase 3 - AI and automation

Add automation only after the manual process becomes stable:

- MR summary generation
- Risk classification suggestions
- Missing-test detection
- Access-expiry reminders
- Release note drafting
- Audit report preparation

Use `docs/gitlab/automation-readiness.md` before adding any automation that changes project settings, access, branches, or production state.

## Phase 4 - OGEDAYhub foundation

After the process stabilizes, the same model can become the foundation for OGEDAYhub:

- Central task visibility
- Role-based operational dashboards
- Access lifecycle tracking
- Release readiness tracking
- Audit-friendly engineering history

## Rollback plan

If GitLab migration blocks production work:

- Keep GitHub repository as the fallback source of truth until cutover is complete.
- Use `docs/gitlab/github-fallback-plan.md` during the pilot.
- Use `docs/gitlab/cutover-checklist.md` before declaring GitLab primary.
- Keep production deploy manual until runner and secret handling are verified.
- Do not remove existing live server access before GitLab access recovery is tested.
- Export GitLab project data after the first pilot week.

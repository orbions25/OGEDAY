# OGEDAY GitLab Migration Runbook

This runbook describes how to apply the self-hosted GitLab model to the current OGEDAY website repository without disrupting the live `ogedays.com` site.

## Phase 0 - Decisions before migration

- Decide the GitLab domain and hosting target.
- Decide whether the initial GitLab server is single-node or prepared for later scaling.
- Decide real GitLab groups for Software Admin, Supervisor, Developer, QA, and Read-only visibility.
- Decide backup storage location and retention policy.
- Decide who can approve production access.

## Phase 1A - GitLab Core

- Install GitLab.
- Enable HTTPS.
- Create the OGEDAY group.
- Import or mirror this repository.
- Create real GitLab groups that replace the placeholder `CODEOWNERS` entries.
- Protect `main`.
- Disable direct push to `main`.
- Enable merge request pipeline requirements.
- Configure runner capacity for static validation jobs.

## Phase 1B - Operational Discipline

- Enable issue templates.
- Enable merge request templates.
- Require a linked issue for every merge request.
- Use Access Request issues for restricted resources.
- Use QA Validation issues for release checks.
- Add CODEOWNERS approval for `ops/`, `.gitlab/`, `scripts/`, and deploy files.

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
- Build a short monthly governance report from issues, MRs, and pipeline data.

## Phase 3 - AI and automation

Add automation only after the manual process becomes stable:

- MR summary generation
- Risk classification suggestions
- Missing-test detection
- Access-expiry reminders
- Release note drafting
- Audit report preparation

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
- Keep production deploy manual until runner and secret handling are verified.
- Do not remove existing live server access before GitLab access recovery is tested.
- Export GitLab project data after the first pilot week.


# OGEDAY GitLab Pilot Execution Plan

This plan turns the self-hosted GitLab model into the first week of practical work.

## Day 0 - Readiness

- Confirm GitLab FQDN and DNS owner.
- Confirm target server size and storage.
- Run `ops/gitlab/preflight-check.sh` on the target server.
- Confirm backup storage location.
- Confirm first restore-test date.
- Confirm Software Admin and Supervisor names.

Exit criteria:

- No critical server sizing issue remains open.
- DNS path is known.
- Backup and restore owner is assigned.

## Day 1 - GitLab core install

- Run `ops/gitlab/install-single-node-ubuntu.sh` in dry-run mode.
- Review commands with Software Admin.
- Run install with `DRY_RUN=0` on the target server.
- Apply relevant settings from `ops/gitlab/gitlab.rb.example`.
- Confirm admin sign-in and disable open signup.

Exit criteria:

- GitLab UI is reachable over HTTPS.
- Admin access is secured.
- Configuration backup command has been tested once.

## Day 2 - Repository import

- Create OGEDAY group.
- Import `https://github.com/orbions25/OGEDAY.git`.
- Create groups from `ops/gitlab/bootstrap-groups.md`.
- Replace placeholder `CODEOWNERS` entries.
- Review and run `ops/gitlab/apply-labels.sh`.
- Review and run `ops/gitlab/protect-main.sh`.
- Apply project settings checklist.

Exit criteria:

- Project exists in GitLab.
- `main` is protected.
- Direct push to `main` is disabled.
- CODEOWNERS uses real GitLab groups.
- Core operational labels exist.

## Day 3 - Runner and CI

- Create runner in GitLab UI and copy the `glrt-` runner authentication token.
- Install runner on a separate machine using `ops/gitlab/install-runner-ubuntu.sh`.
- Run the first pipeline.
- Run `ops/gitlab/project-readiness-check.sh`.
- Fix only pipeline issues, not production deploy automation.

Exit criteria:

- Static site validation passes.
- Operational policy validation passes.
- Runner appears online and scoped correctly.

## Day 4 - Process pilot

- Create one Task issue for a small documentation change.
- Open one Merge Request from that task.
- Complete MR template fields.
- Complete Supervisor review checklist.
- Merge only after pipeline passes.

Exit criteria:

- First task-driven MR is completed.
- The team sees the intended workflow end-to-end.

## Day 5 - Access and release rehearsal

- Create a test Access Request issue without granting real production access.
- Create a QA Validation issue for the website.
- Create a Release Checklist issue for a dry-run release review.

Exit criteria:

- Access flow is understood.
- Release checklist is usable.
- QA evidence format is clear.

## Day 6 - Backup and restore test

- Run application and configuration backup.
- Restore to a clean test instance with the same GitLab version and type.
- Record results in `docs/gitlab/audit-register.md` or a GitLab issue.

Exit criteria:

- Restore procedure is proven.
- Any missing recovery steps are documented.

## Day 7 - Pilot review

- Review labels, boards, templates, and approval bottlenecks.
- Fill `docs/gitlab/monthly-governance-report-template.md` for the pilot week.
- Review `docs/gitlab/cutover-checklist.md`.
- Confirm `docs/gitlab/github-fallback-plan.md` is still valid.
- Decide whether GitLab becomes primary or continues in parallel with GitHub.

Exit criteria:

- Go/no-go decision is recorded.
- GitHub fallback decision is explicit.
- Next automation candidates are listed.

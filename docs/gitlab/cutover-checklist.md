# OGEDAY GitLab Cutover Checklist

Use this checklist before declaring self-hosted GitLab as the primary source of truth.

## Preconditions

- [ ] GitLab UI is reachable over HTTPS.
- [ ] Admin access is secured and open signup is disabled.
- [ ] OGEDAY project is imported.
- [ ] GitHub remains available as fallback.
- [ ] `main` is protected in GitLab.
- [ ] Direct push to `main` is disabled.
- [ ] CODEOWNERS uses real GitLab groups.
- [ ] Required labels exist.
- [ ] Runner is online.
- [ ] Static site validation pipeline passes.
- [ ] Operational policy validation pipeline passes.
- [ ] First backup has completed.
- [ ] First restore test has completed on a clean test instance.

## Workflow proof

- [ ] One Task issue has been completed through MR.
- [ ] One QA Validation issue has been completed.
- [ ] One Release Checklist issue has been completed as a dry-run.
- [ ] One Access Request issue has been rehearsed without production access.
- [ ] One audit event has been recorded.

## People and roles

- [ ] Software Admin group is assigned.
- [ ] Supervisor group is assigned.
- [ ] Frontend/DevOps/QA groups are assigned.
- [ ] Emergency contact is documented.
- [ ] Backup owner is documented.
- [ ] Restore owner is documented.

## Go / no-go

Declare GitLab primary only if every critical item above is complete.

Decision:

- [ ] Go
- [ ] No-go

Decision maker:

Decision date:

Notes:


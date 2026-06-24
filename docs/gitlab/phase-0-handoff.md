# OGEDAY GitLab Phase 0 Handoff

Use this document to coordinate the final handoff before the first GitLab installation window.

## DNS owner handoff

Send the DNS owner:

- `docs/gitlab/dns-change-request.md`
- Target GitLab server public IPv4
- Target GitLab server public IPv6, if any
- Requested TTL during pilot
- Validation command from `ops/gitlab/dns-readiness.ps1` or `ops/gitlab/dns-readiness.sh`

Required output:

- DNS record is created.
- DNS value is confirmed.
- DNS readiness check passes with `FailOnMissingGitLab` or `FAIL_ON_MISSING_GITLAB=1`.

## Infrastructure owner handoff

Send the infrastructure owner:

- `docs/gitlab/server-provisioning-checklist.md`
- `docs/gitlab/install-day-runbook.md`
- `ops/gitlab/phase-0.env.example`
- `ops/gitlab/preflight-check.sh`

Required output:

- Server provider, region, CPU, RAM, disk, and OS are recorded.
- SSH, HTTP, and HTTPS exposure is intentional.
- Backup storage location is identified outside the GitLab server.
- Restore-test target is identified.

## Software Admin handoff

Send the Software Admin:

- `docs/gitlab/infrastructure-decision-record.md`
- `docs/gitlab/phase-0-go-no-go.md`
- `docs/gitlab/github-fallback-plan.md`
- `ops/gitlab/README.md`

Required output:

- Software Admin owner is recorded.
- Supervisor owner is recorded.
- Emergency contact is recorded.
- GitHub fallback owner is recorded.
- Phase 0 go/no-go check is run.

## Current blocker pattern

If `phase-0-go-no-go` says `Go to install: False`, do not install GitLab yet.

Resolve blockers in this order:

1. Fill missing infrastructure decisions.
2. Create DNS record.
3. Run DNS readiness.
4. Run target server preflight.
5. Run Phase 0 go/no-go again.


# OGEDAY GitLab Phase 0 Readiness

Phase 0 exists to avoid installing GitLab before the operational basics are clear.

## Required decisions

Record each decision in `docs/gitlab/infrastructure-decision-record.md` before installation.

- GitLab FQDN, recommended: `gitlab.ogedays.com`
- DNS owner and provider
- Target server provider and region
- Server sizing
- Backup storage location
- Restore-test target
- Runner machine target
- Software Admin owner
- Supervisor owner
- Emergency contact
- GitHub fallback owner

## Current default assumption

The repository assumes the first pilot FQDN will be:

```text
gitlab.ogedays.com
```

This must resolve to the selected GitLab server before HTTPS installation is treated as complete.

## Minimum readiness gates

- [ ] DNS record exists for GitLab FQDN.
- [ ] DNS change request is complete.
- [ ] Server provisioning checklist is complete.
- [ ] HTTPS plan is selected.
- [ ] SSH, HTTP, and HTTPS firewall rules are known.
- [ ] Target server has enough CPU, memory, and disk.
- [ ] Backup location exists outside the GitLab server.
- [ ] Restore test date is scheduled.
- [ ] Runner machine is separate from the GitLab instance, unless explicitly deferred.
- [ ] GitHub fallback plan is still active.

## Commands

From Windows:

```powershell
powershell -ExecutionPolicy Bypass -File ops/gitlab/dns-readiness.ps1
powershell -ExecutionPolicy Bypass -File ops/gitlab/phase-0-go-no-go.ps1
```

From Linux:

```bash
sh ops/gitlab/dns-readiness.sh
sh ops/gitlab/phase-0-go-no-go.sh
```

On the target GitLab server:

```bash
GITLAB_EXTERNAL_URL="https://gitlab.ogedays.com" sh ops/gitlab/preflight-check.sh
```

# OGEDAY GitLab Server Provisioning Checklist

Use this checklist before running the GitLab install script.

## Server identity

- Provider:
- Region:
- Hostname:
- Public IPv4:
- Public IPv6:
- Operating system:
- SSH user:
- Emergency access owner:

## Sizing

- CPU:
- RAM:
- Disk:
- Disk type:
- Backup disk or external storage:

Minimum planning guidance for the pilot:

- Prefer at least 8 vCPU for a standard small single-node target.
- Prefer at least 8 GB RAM, with 16 GB better if available.
- Plan at least 40 GB disk before repository data.
- Prefer SSD-backed storage.

## Network

- [ ] DNS record planned.
- [ ] SSH `22` intentionally allowed.
- [ ] HTTP `80` intentionally allowed.
- [ ] HTTPS `443` intentionally allowed.
- [ ] SSH is restricted or rate-limited where possible.

## Security baseline

- [ ] Root/admin password handling is defined.
- [ ] SSH keys are documented outside the repository.
- [ ] Open signup will be disabled.
- [ ] Backup storage is outside the GitLab server.
- [ ] Restore-test target is identified.

## Preflight

Run on the target GitLab server:

```bash
GITLAB_EXTERNAL_URL="https://gitlab.ogedays.com" sh ops/gitlab/preflight-check.sh
```


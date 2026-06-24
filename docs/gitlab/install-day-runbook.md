# OGEDAY GitLab Install Day Runbook

Use this runbook on the first real installation day.

## Before the window

- [ ] Phase 0 readiness is approved.
- [ ] DNS change request is complete.
- [ ] Server provisioning checklist is complete.
- [ ] Backup storage exists.
- [ ] Restore-test target is known.
- [ ] GitHub fallback plan is active.
- [ ] Operator has server access.
- [ ] Emergency contact is online.

## Install sequence

1. Run DNS readiness check.
2. Run target server preflight check.
3. Run install script in dry-run mode.
4. Review the printed commands.
5. Run install script with `DRY_RUN=0`.
6. Sign in to GitLab as admin.
7. Disable open signup.
8. Apply `gitlab.rb.example` settings manually where appropriate.
9. Run `sudo gitlab-ctl reconfigure`.
10. Run `sudo gitlab-ctl status`.
11. Run the first configuration backup.

## Commands

Print the current command pack:

```bash
sh ops/gitlab/print-phase-0-commands.sh
```

```bash
GITLAB_EXTERNAL_URL="https://gitlab.ogedays.com" sh ops/gitlab/preflight-check.sh
GITLAB_EXTERNAL_URL="https://gitlab.ogedays.com" sh ops/gitlab/install-single-node-ubuntu.sh
DRY_RUN=0 GITLAB_EXTERNAL_URL="https://gitlab.ogedays.com" sh ops/gitlab/install-single-node-ubuntu.sh
```

## Stop conditions

Stop the install if:

- DNS points to the wrong server.
- Target server is undersized and no exception is approved.
- Backup storage is not defined.
- Admin access cannot be secured.
- HTTPS cannot be completed.
- GitHub fallback is not available.

## After install

- [ ] Create OGEDAY group.
- [ ] Import repository.
- [ ] Create GitLab groups.
- [ ] Replace CODEOWNERS placeholders.
- [ ] Apply labels.
- [ ] Protect `main`.
- [ ] Register runner.
- [ ] Run first pipeline.
- [ ] Schedule restore test.

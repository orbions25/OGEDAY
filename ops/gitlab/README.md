# OGEDAY Self-Hosted GitLab Ops

This folder contains the practical bootstrap assets for the OGEDAY self-hosted GitLab migration.

The scripts are intentionally safe by default:

- They run in dry-run mode unless `DRY_RUN=0` is set.
- They require explicit environment variables for URLs and tokens.
- They do not contain secrets.
- They do not enable production deploy automation.

## Recommended order

1. Prepare DNS for the GitLab FQDN, for example `gitlab.ogedays.com`.
2. Provision a Debian/Ubuntu server that satisfies GitLab single-node requirements.
3. Record Phase 0 decisions in `docs/gitlab/infrastructure-decision-record.md`.
4. Run `dns-readiness.ps1` from Windows or `dns-readiness.sh` from Linux.
5. Complete `docs/gitlab/dns-change-request.md` and `docs/gitlab/server-provisioning-checklist.md`.
6. Review `docs/gitlab/phase-0-handoff.md`.
7. Print the command pack with `print-phase-0-commands.ps1` or `print-phase-0-commands.sh`.
8. Run `phase-0-go-no-go.ps1` from Windows or `phase-0-go-no-go.sh` from Linux.
9. Run `preflight-check.sh` on the target server.
10. Run `install-single-node-ubuntu.sh` in dry-run mode and review the output.
11. Run the same install script with `DRY_RUN=0` only on the target GitLab server.
12. Create the OGEDAY group and import this repository.
13. Create real GitLab groups and replace placeholder entries in `CODEOWNERS`.
14. Use `api-bootstrap.md` to review and apply labels and `main` branch protection.
15. Configure remaining project settings from `docs/gitlab/project-settings-checklist.md`.
16. Use `create-pilot-issues.sh` to review the first workflow rehearsal issues.
17. Create a runner in GitLab UI and install/register it on a separate runner machine.
18. Run the first pipeline.
19. Run a backup and restore test before GitLab becomes the only source of truth.

## Files

- `install-single-node-ubuntu.sh`
  - Dry-run first install helper for GitLab Linux package deployments.
- `dns-readiness.ps1`
  - Windows DNS readiness check for the root domain and GitLab FQDN.
- `dns-readiness.sh`
  - Linux DNS readiness check for the root domain and GitLab FQDN.
- `phase-0-go-no-go.ps1`
  - Windows Phase 0 readiness summary and install go/no-go helper.
- `phase-0-go-no-go.sh`
  - Linux Phase 0 readiness summary and install go/no-go helper.
- `phase-0.env.example`
  - Non-secret environment template for Phase 0 and bootstrap scripts.
- `print-phase-0-commands.ps1`
  - Windows command pack printer for DNS, go/no-go, preflight, and install commands.
- `print-phase-0-commands.sh`
  - Linux command pack printer for DNS, go/no-go, preflight, and install commands.
- `preflight-check.sh`
  - Read-only target-server readiness check for CPU, memory, disk, and DNS.
- `gitlab.rb.example`
  - Minimal configuration reference for `/etc/gitlab/gitlab.rb`.
- `install-runner-ubuntu.sh`
  - Dry-run first runner install and registration helper using runner authentication tokens.
- `backup-gitlab.sh`
  - Backup helper for application and `/etc/gitlab` configuration backups.
- `restore-test-checklist.sh`
  - Restore-test command guide for a clean test instance.
- `api-bootstrap.md`
  - API-based label and protected branch bootstrap instructions.
- `apply-labels.sh`
  - Dry-run first project label creation helper.
- `protect-main.sh`
  - Dry-run first `main` branch protection helper.
- `project-readiness-check.sh`
  - API readiness check for project, labels, and protected branch.
- `create-pilot-issues.sh`
  - Dry-run first pilot issue creation helper for Task, QA, Release, and Access rehearsals.
- `import-ogeday-repo.md`
  - Project import and post-import checklist.
- `bootstrap-groups.md`
  - Initial group, role, and CODEOWNERS bootstrap guide.
- `source-links.md`
  - Official GitLab documentation links used while preparing this folder.

## Non-goals

- No automatic production deployment is configured yet.
- No secret, token, SSH key, DNS credential, or server password belongs in this repository.
- No script should be run on the live OGEDAY web server unless the operator intentionally chooses that target.

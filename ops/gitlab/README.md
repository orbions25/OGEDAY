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
5. Run `preflight-check.sh` on the target server.
6. Run `install-single-node-ubuntu.sh` in dry-run mode and review the output.
7. Run the same install script with `DRY_RUN=0` only on the target GitLab server.
8. Create the OGEDAY group and import this repository.
9. Create real GitLab groups and replace placeholder entries in `CODEOWNERS`.
10. Use `api-bootstrap.md` to review and apply labels and `main` branch protection.
11. Configure remaining project settings from `docs/gitlab/project-settings-checklist.md`.
12. Use `create-pilot-issues.sh` to review the first workflow rehearsal issues.
13. Create a runner in GitLab UI and install/register it on a separate runner machine.
14. Run the first pipeline.
15. Run a backup and restore test before GitLab becomes the only source of truth.

## Files

- `install-single-node-ubuntu.sh`
  - Dry-run first install helper for GitLab Linux package deployments.
- `dns-readiness.ps1`
  - Windows DNS readiness check for the root domain and GitLab FQDN.
- `dns-readiness.sh`
  - Linux DNS readiness check for the root domain and GitLab FQDN.
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

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
3. Run `preflight-check.sh` on the target server.
4. Run `install-single-node-ubuntu.sh` in dry-run mode and review the output.
5. Run the same install script with `DRY_RUN=0` only on the target GitLab server.
6. Create the OGEDAY group and import this repository.
7. Create real GitLab groups and replace placeholder entries in `CODEOWNERS`.
8. Configure project settings from `docs/gitlab/project-settings-checklist.md`.
9. Create a runner in GitLab UI and install/register it on a separate runner machine.
10. Run the first pipeline.
11. Run a backup and restore test before GitLab becomes the only source of truth.

## Files

- `install-single-node-ubuntu.sh`
  - Dry-run first install helper for GitLab Linux package deployments.
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

# OGEDAY GitHub Fallback Plan

During the pilot, GitHub should remain the fallback source of truth until GitLab install, runner, backup, restore, and workflow checks pass.

## Fallback rules

- Do not delete the GitHub remote during the pilot.
- Do not disable GitHub access until GitLab restore has been tested.
- Do not make GitLab the only deploy path until the first release rehearsal passes.
- If GitLab blocks production work, use GitHub `main` as the fallback source.

## Local remote layout

Recommended local remote names during the pilot:

```bash
git remote -v
```

Expected:

```text
origin  https://github.com/orbions25/OGEDAY.git
gitlab  <self-hosted-gitlab-project-url>
```

## Sync direction during pilot

Default direction:

```text
GitHub main -> GitLab pilot project
```

After cutover:

```text
GitLab main -> GitHub fallback mirror
```

Do not reverse the direction until `docs/gitlab/cutover-checklist.md` is approved.

## Emergency fallback

If GitLab is unavailable during an urgent website fix:

- Open an Incident Report issue once GitLab is available again.
- Apply the fix through GitHub.
- Record the reason in the audit register.
- Sync the final GitHub state back into GitLab after recovery.
- Review why GitLab was unavailable before resuming cutover.


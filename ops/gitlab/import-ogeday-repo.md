# Import OGEDAY Repository Into GitLab

This is the first project import flow for the self-hosted GitLab pilot.

## Before import

- Confirm GitHub remains the fallback source of truth during the pilot.
- Confirm GitLab backup and restore process has at least one scheduled test date.
- Confirm the OGEDAY group exists.
- Confirm Software Admin and Supervisor groups exist.

## Import options

### Option A - GitLab UI import

Use GitLab project import from repository URL:

```text
https://github.com/orbions25/OGEDAY.git
```

After import:

- Set default branch to `main`.
- Protect `main`.
- Disable direct push to `main`.
- Require merge requests and pipeline success.
- Enable CODEOWNERS approval after real group names are configured.

### Option B - Local mirror push

Use this only after the GitLab project exists and the operator has permission.

```bash
git remote add gitlab <gitlab-project-url>
git push gitlab main
git push gitlab --tags
```

Do not remove the GitHub remote until the pilot is complete.

## Post-import checklist

- Replace placeholder `@software-admin` and `@supervisor` entries in `CODEOWNERS`.
- Create labels from `docs/gitlab/labels.md`.
- Confirm issue templates appear in GitLab.
- Confirm merge request template appears in GitLab.
- Run the first pipeline.
- Open a QA Validation issue for the first pilot release check.
- Open an Access Request issue for any production/server action.


# GitLab API Bootstrap

These scripts reduce manual GitLab setup after the self-hosted instance and OGEDAY project exist.

They are safe by default:

- `apply-labels.sh` and `protect-main.sh` run in dry-run mode unless `DRY_RUN=0` is set.
- No token is required for dry-run review.
- No script stores a token in the repository.

## Required values

Use a project ID when possible. If you use a project path, URL-encode it.

```bash
export GITLAB_URL="https://gitlab.ogedays.com"
export GITLAB_PROJECT_ID="123"
export GITLAB_TOKEN="redacted"
```

## Apply labels

Review first:

```bash
sh ops/gitlab/apply-labels.sh
```

Apply after review:

```bash
DRY_RUN=0 sh ops/gitlab/apply-labels.sh
```

## Protect main

Review first:

```bash
sh ops/gitlab/protect-main.sh
```

Apply after review:

```bash
DRY_RUN=0 sh ops/gitlab/protect-main.sh
```

The protected branch script configures:

- No direct push to `main`
- Maintainer merge access
- Maintainer unprotect access
- Force push disabled

## Check readiness

After labels and branch protection are applied:

```bash
sh ops/gitlab/project-readiness-check.sh
```

The readiness check confirms:

- Project API is readable
- `main` is protected
- Core operational labels exist

## Create pilot issues

Review first:

```bash
sh ops/gitlab/create-pilot-issues.sh
```

Apply after review:

```bash
DRY_RUN=0 sh ops/gitlab/create-pilot-issues.sh
```

This creates rehearsal issues for:

- Task-driven MR workflow
- QA Validation
- Release Checklist dry-run
- Access Request rehearsal without production access

## Official API references

- Project Labels API: https://docs.gitlab.com/api/labels/
- Issues API: https://docs.gitlab.com/api/issues/
- Protected Branches API: https://docs.gitlab.com/api/protected_branches/
- Projects API: https://docs.gitlab.com/api/projects/

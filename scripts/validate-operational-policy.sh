#!/bin/sh
set -eu

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || fail "Missing required file: $1"
}

require_contains() {
  file="$1"
  text="$2"
  label="$3"
  grep -Fq "$text" "$file" || fail "$label not found in $file"
}

mr_template=".gitlab/merge_request_templates/Default.md"
access_template=".gitlab/issue_templates/Access_Request.md"

require_file "$mr_template"
require_file "$access_template"
require_file .gitlab/issue_templates/Task.md
require_file .gitlab/issue_templates/QA_Validation.md
require_file .gitlab/issue_templates/Release_Checklist.md
require_file .gitlab/issue_templates/Incident_Report.md
require_file CODEOWNERS
require_file docs/gitlab/operational-model.md
require_file docs/gitlab/migration-runbook.md
require_file docs/gitlab/role-matrix.md
require_file docs/gitlab/labels.md
require_file docs/gitlab/project-settings-checklist.md
require_file docs/gitlab/audit-register.md
require_file docs/gitlab/runner-secrets-policy.md
require_file docs/gitlab/backup-restore-checklist.md
require_file docs/gitlab/monthly-governance-report-template.md
require_file ops/gitlab/README.md
require_file ops/gitlab/preflight-check.sh
require_file ops/gitlab/install-single-node-ubuntu.sh
require_file ops/gitlab/gitlab.rb.example
require_file ops/gitlab/install-runner-ubuntu.sh
require_file ops/gitlab/backup-gitlab.sh
require_file ops/gitlab/restore-test-checklist.sh
require_file ops/gitlab/import-ogeday-repo.md
require_file ops/gitlab/bootstrap-groups.md
require_file ops/gitlab/source-links.md
require_file docs/gitlab/pilot-execution-plan.md

require_contains "$mr_template" "Linked issue" "MR linked issue field"
require_contains "$mr_template" "Scope" "MR scope field"
require_contains "$mr_template" "Test result" "MR test result field"
require_contains "$mr_template" "Rollback" "MR rollback field"

require_contains "$access_template" "Requested resource" "Access request resource field"
require_contains "$access_template" "Business reason" "Access request business reason field"
require_contains "$access_template" "Access duration" "Access request duration field"
require_contains "$access_template" "Supervisor note" "Access request supervisor note field"
require_contains "$access_template" "Approval history" "Access request approval history field"

require_contains .gitlab/issue_templates/Release_Checklist.md "Pre-deploy checks" "Release pre-deploy checks"
require_contains .gitlab/issue_templates/Release_Checklist.md "Post-deploy smoke test" "Release post-deploy smoke test"
require_contains .gitlab/issue_templates/Incident_Report.md "Emergency access" "Incident emergency access section"
require_contains docs/gitlab/labels.md "type::access-request" "Access request label"
require_contains docs/gitlab/project-settings-checklist.md 'Direct push to `main` is disabled' "Protected branch checklist"
require_contains docs/gitlab/audit-register.md "Permission grants" "Audit register permission category"
require_contains docs/gitlab/runner-secrets-policy.md "protected branches" "Runner protected branch policy"
require_contains docs/gitlab/backup-restore-checklist.md "Restore test" "Backup restore test section"
require_contains docs/gitlab/monthly-governance-report-template.md "Access summary" "Monthly governance access summary"
require_contains ops/gitlab/README.md "DRY_RUN=0" "GitLab ops dry-run note"
require_contains ops/gitlab/preflight-check.sh "GITLAB_EXTERNAL_URL" "GitLab preflight external URL guard"
require_contains ops/gitlab/preflight-check.sh "40 GB" "GitLab preflight storage guidance"
require_contains ops/gitlab/install-single-node-ubuntu.sh "GITLAB_EXTERNAL_URL" "GitLab install external URL guard"
require_contains ops/gitlab/install-runner-ubuntu.sh "RUNNER_AUTH_TOKEN" "Runner authentication token guard"
require_contains ops/gitlab/backup-gitlab.sh "gitlab-backup create" "GitLab backup command"
require_contains ops/gitlab/restore-test-checklist.sh "same GitLab version and type" "Restore version guard"
require_contains ops/gitlab/import-ogeday-repo.md "https://github.com/orbions25/OGEDAY.git" "OGEDAY import source"
require_contains ops/gitlab/bootstrap-groups.md "OGEDAY/software-admin" "Software Admin group guide"
require_contains docs/gitlab/pilot-execution-plan.md "Day 3 - Runner and CI" "Pilot runner day"

printf 'Operational policy validation passed.\n'

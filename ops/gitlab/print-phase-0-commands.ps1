param(
  [string]$GitLabExternalUrl = "https://gitlab.ogedays.com",
  [string]$GitLabHost = "gitlab.ogedays.com"
)

$ErrorActionPreference = "Stop"

Write-Output "OGEDAY GitLab Phase 0 command pack"
Write-Output ""
Write-Output "1. DNS readiness"
Write-Output "powershell -ExecutionPolicy Bypass -File ops/gitlab/dns-readiness.ps1 -GitLabHost `"$GitLabHost`" -FailOnMissingGitLab"
Write-Output ""
Write-Output "2. Phase 0 go/no-go"
Write-Output "powershell -ExecutionPolicy Bypass -File ops/gitlab/phase-0-go-no-go.ps1 -GitLabHost `"$GitLabHost`""
Write-Output ""
Write-Output "3. Target server preflight, run on the GitLab server"
Write-Output "GITLAB_EXTERNAL_URL=`"$GitLabExternalUrl`" sh ops/gitlab/preflight-check.sh"
Write-Output ""
Write-Output "4. Install dry-run, run on the GitLab server"
Write-Output "GITLAB_EXTERNAL_URL=`"$GitLabExternalUrl`" sh ops/gitlab/install-single-node-ubuntu.sh"
Write-Output ""
Write-Output "5. Real install, only after go/no-go is approved"
Write-Output "DRY_RUN=0 GITLAB_EXTERNAL_URL=`"$GitLabExternalUrl`" sh ops/gitlab/install-single-node-ubuntu.sh"


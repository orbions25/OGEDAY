param(
  [string]$GitLabHost = "gitlab.ogedays.com",
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$requiredFiles = @(
  "docs/gitlab/phase-0-readiness.md",
  "docs/gitlab/dns-and-tls-plan.md",
  "docs/gitlab/infrastructure-decision-record.md",
  "docs/gitlab/dns-change-request.md",
  "docs/gitlab/server-provisioning-checklist.md",
  "docs/gitlab/install-day-runbook.md",
  "docs/gitlab/phase-0-go-no-go.md",
  "docs/gitlab/github-fallback-plan.md"
)

$missing = @()
foreach ($file in $requiredFiles) {
  if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
    $missing += $file
  }
}

$decisionRecord = "docs/gitlab/infrastructure-decision-record.md"
$openDecisionTopics = @(
  "DNS provider",
  "GitLab server provider",
  "GitLab server region",
  "GitLab server size",
  "Backup storage",
  "Restore-test target",
  "Runner machine",
  "Software Admin owner",
  "Supervisor owner",
  "Emergency contact",
  "GitHub fallback owner"
)

$openDecisions = @()
if (Test-Path -LiteralPath $decisionRecord -PathType Leaf) {
  $body = Get-Content -LiteralPath $decisionRecord -Raw
  foreach ($topic in $openDecisionTopics) {
    if ($body.Contains("| $topic |  |")) {
      $openDecisions += $topic
    }
  }
}

$dnsResolves = $false
try {
  Resolve-DnsName $GitLabHost -ErrorAction Stop | Out-Null
  $dnsResolves = $true
} catch {
  $dnsResolves = $false
}

Write-Output "Phase 0 Go/No-Go check"
Write-Output "GitLab host: $GitLabHost"
Write-Output "DNS resolves: $dnsResolves"

if ($missing.Count -gt 0) {
  Write-Warning "Missing files: $($missing -join ', ')"
}

if ($openDecisions.Count -gt 0) {
  Write-Warning "Open decisions: $($openDecisions -join ', ')"
}

if (-not $dnsResolves) {
  Write-Warning "$GitLabHost does not resolve yet."
}

$ready = ($missing.Count -eq 0) -and ($openDecisions.Count -eq 0) -and $dnsResolves
Write-Output "Go to install: $ready"

if ($Strict -and -not $ready) {
  exit 1
}


param(
  [string]$GitLabHost = "gitlab.ogedays.com",
  [string]$RootDomain = "ogedays.com",
  [switch]$FailOnMissingGitLab
)

$ErrorActionPreference = "Stop"

function Resolve-Host {
  param([string]$Name)

  try {
    $records = Resolve-DnsName $Name -ErrorAction Stop
    $addresses = $records | Where-Object { $_.IPAddress } | Select-Object -ExpandProperty IPAddress -Unique
    [pscustomobject]@{
      Name = $Name
      Resolves = $true
      Addresses = ($addresses -join ", ")
    }
  } catch {
    [pscustomobject]@{
      Name = $Name
      Resolves = $false
      Addresses = ""
    }
  }
}

$root = Resolve-Host $RootDomain
$gitlab = Resolve-Host $GitLabHost

$root | Format-List
$gitlab | Format-List

if (-not $gitlab.Resolves) {
  Write-Warning "$GitLabHost does not resolve yet. Add an A or AAAA record before GitLab HTTPS install is considered ready."
  if ($FailOnMissingGitLab) {
    exit 1
  }
}

Write-Output "DNS readiness check completed."


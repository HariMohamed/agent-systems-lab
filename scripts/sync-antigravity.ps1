$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition | Split-Path -Parent
$CodexSync = Join-Path $RepoRoot "scripts\sync-codex.ps1"
if (-not (Test-Path -LiteralPath $CodexSync -PathType Leaf)) {
    throw "Shared approved-skill projection script was not found: $CodexSync"
}

Write-Host "Syncing the shared .agents/skills projection from approved canonical sources..."
& $CodexSync -RepoRoot $RepoRoot

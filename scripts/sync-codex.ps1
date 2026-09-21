param(
    [string]$RepoRoot = (Split-Path -Parent $MyInvocation.MyCommand.Definition | Split-Path -Parent)
)

$ErrorActionPreference = 'Stop'

$ApprovedDir = Join-Path $RepoRoot 'skills\approved'
$ProjectionDir = Join-Path $RepoRoot '.agents\skills'

if (-not (Test-Path -LiteralPath $ApprovedDir -PathType Container)) {
    throw "Canonical approved skills directory was not found: $ApprovedDir"
}

$approvedSkills = @(Get-ChildItem -LiteralPath $ApprovedDir -Directory -Force | Sort-Object Name)
$workflows = @()
if (Test-Path -LiteralPath (Join-Path $RepoRoot 'workflows') -PathType Container) {
    $workflows = @(Get-ChildItem -LiteralPath (Join-Path $RepoRoot 'workflows') -Directory -Force | Sort-Object Name)
}
$allSkills = $approvedSkills + $workflows

$sourceNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
$validationErrors = [System.Collections.Generic.List[string]]::new()

foreach ($skill in $allSkills) {
    if (-not $sourceNames.Add($skill.Name)) {
        $validationErrors.Add("Duplicate approved skill directory: $($skill.Name)")
    }

    if ($skill.Name -notmatch '^[a-z0-9-]+$') {
        $validationErrors.Add("Invalid approved skill directory name: $($skill.Name)")
    }

    $skillFile = Join-Path $skill.FullName 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
        $skillFile = Join-Path $skill.FullName 'WORKFLOW.md'
        if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
            $validationErrors.Add("Approved skill/workflow is missing SKILL.md/WORKFLOW.md: $($skill.Name)")
            continue
        }
    }

    $content = [System.IO.File]::ReadAllText($skillFile)
    if ($content -notmatch '(?ms)^---\r?\n.*?^name:\s*["'']?([a-z0-9-]+)["'']?\s*\r?$.*?^description:\s*.+?\r?\n.*?^---\r?\n') {
        $validationErrors.Add("Approved skill has invalid or incomplete SKILL.md metadata: $($skill.Name)")
    } elseif ($Matches[1] -ne $skill.Name) {
        $validationErrors.Add("SKILL.md name does not match directory name: $($skill.Name)")
    }
}

if ($validationErrors.Count -gt 0) {
    $validationErrors | ForEach-Object { Write-Error $_ }
    throw 'Codex projection aborted before changing the target directory.'
}

if (-not (Test-Path -LiteralPath $ProjectionDir -PathType Container)) {
    New-Item -ItemType Directory -Path $ProjectionDir -Force | Out-Null
}

$changed = 0
$removed = 0

function Sync-Directory {
    param([string]$Source, [string]$Target)

    if (-not (Test-Path -LiteralPath $Target -PathType Container)) {
        New-Item -ItemType Directory -Path $Target -Force | Out-Null
    }

    $sourceItems = @(Get-ChildItem -LiteralPath $Source -Force | Sort-Object @{Expression={ $_.PSIsContainer }; Descending=$true}, Name)
    $sourceNamesLocal = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)

    foreach ($item in $sourceItems) {
        $sourceNamesLocal.Add($item.Name) | Out-Null
        $targetItem = Join-Path $Target $item.Name

        if ($item.PSIsContainer) {
            Sync-Directory -Source $item.FullName -Target $targetItem
        } else {
            $needsCopy = $true
            if (Test-Path -LiteralPath $targetItem -PathType Leaf) {
                $needsCopy = -not ((Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash -eq (Get-FileHash -LiteralPath $targetItem -Algorithm SHA256).Hash)
            }
            if ($needsCopy) {
                Copy-Item -LiteralPath $item.FullName -Destination $targetItem -Force
                $script:changed++
            }
        }
    }

    foreach ($stale in @(Get-ChildItem -LiteralPath $Target -Force | Where-Object { -not $sourceNamesLocal.Contains($_.Name) })) {
        Remove-Item -LiteralPath $stale.FullName -Recurse -Force
        $script:removed++
    }
}

foreach ($skill in $allSkills) {
    Sync-Directory -Source $skill.FullName -Target (Join-Path $ProjectionDir $skill.Name)
    Write-Host "Projected approved skill: $($skill.Name)"
}

foreach ($staleSkill in @(Get-ChildItem -LiteralPath $ProjectionDir -Force | Where-Object { -not $sourceNames.Contains($_.Name) })) {
    Remove-Item -LiteralPath $staleSkill.FullName -Recurse -Force
    $removed++
    Write-Host "Removed stale generated skill: $($staleSkill.Name)"
}

Write-Host "Codex projection complete. Approved: $($approvedSkills.Count); files changed: $changed; entries removed: $removed; target: $ProjectionDir"

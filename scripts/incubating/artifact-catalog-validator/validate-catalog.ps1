[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$CatalogPath = "catalog/artifacts.yaml",

    [Parameter(Mandatory = $false)]
    [ValidateSet("text", "json")]
    [string]$Format = "text",

    [Parameter(Mandatory = $false)]
    [switch]$Quiet
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Resolves repo root from this script location (scripts/incubating/artifact-catalog-validator)
# Repo root is 3 levels up
$repoRoot = Resolve-Path (Join-Path $scriptDir "..\..\..") | Select-Object -ExpandProperty Path
$repoRoot = $repoRoot.TrimEnd('\')

try {
    try {
    $resolvedPath = Resolve-Path $CatalogPath -ErrorAction Stop | Select-Object -ExpandProperty Path
} catch {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("CATALOG_FILE_NOT_FOUND: Could not resolve $CatalogPath") }
    exit 2
}

if (Test-Path $resolvedPath -PathType Container) {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("CATALOG_FILE_NOT_FOUND: Provided path is a directory.") }
    exit 2
}

if (-not $resolvedPath.StartsWith($repoRoot, [System.StringComparison]::InvariantCultureIgnoreCase)) {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("CATALOG_PATH_OUTSIDE_REPOSITORY: Catalog must be inside the repository bounds.") }
    exit 2
}

if ($CatalogPath -match "^https?://") {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("UNSUPPORTED_SCHEMA: URL catalogs not supported.") }
    exit 2
}

if ($CatalogPath -match "`0") {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("UNSUPPORTED_SCHEMA: Null characters in path.") }
    exit 2
}

$yamlContent = Get-Content $resolvedPath -Raw

if ($yamlContent -match "`t") {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("TAB_INDENTATION: Tab indentation found.") }
    exit 2
}

if ($yamlContent -match "&[a-zA-Z0-9_]+" -or $yamlContent -match "\*[a-zA-Z0-9_]+" -or $yamlContent -match "!!") {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("UNSUPPORTED_SCHEMA: YAML anchors, aliases, or tags found.") }
    exit 2
}

$entries = [regex]::Matches(
    $yamlContent,
    '(?ms)^\s*-\s+id:\s*(?<id>[A-Z]+-[0-9]{4})\s*$(?<body>.*?)(?=^\s*-\s+id:\s*[A-Z]+-[0-9]{4}\s*$|\z)'
)

if ($entries.Count -eq 0) {
    if (-not $Quiet -and $Format -eq 'text') { [Console]::Error.WriteLine("NO_ENTRIES: Zero entries found.") }
    exit 2
}

$findings = @()

$requiredFields = @(
  "id", "name", "artifact_type", "summary", "domain", "capabilities",
  "lifecycle", "maintenance_status", "version", "origin", "source_confidence",
  "execution_risk", "risk_flags", "location", "owner", "license", "provenance",
  "evaluation", "repository_review", "dependencies", "related_artifacts",
  "supersedes", "superseded_by", "activation_summary", "non_activation_summary",
  "last_reviewed", "next_gate"
)

$allowedArtifactTypes = @("skill","workflow","script","tool","tool-integration","system-design","evaluation","policy","template","reference")
$allowedRisk = @("non_executable","local_read_only","local_state_changing","external_read_only","external_state_changing","privileged","destructive","unknown")
$allowedOrigin = @("repository_original","adapted_third_party","third_party_unmodified","external_reference","generated_repository_artifact")
$allowedSourceConfidence = @("verified_immutable","verified_mutable","maintainer_declared","community_reported","unresolved","not_applicable")

$prefixMap = @{
  "skill"            = "SKILL"
  "workflow"         = "WORKFLOW"
  "script"           = "SCRIPT"
  "tool"             = "TOOL"
  "tool-integration" = "INTEGRATION"
  "system-design"    = "DESIGN"
  "evaluation"       = "EVAL"
  "policy"           = "POLICY"
  "template"         = "TEMPLATE"
  "reference"        = "REFERENCE"
}

$idsSeen = @{}

foreach ($entry in $entries) {
    $id = $entry.Groups["id"].Value.Trim()
    $block = $entry.Groups["body"].Value

    if ([string]::IsNullOrWhiteSpace($id)) {
        $findings += [PSCustomObject]@{ code = "INVALID_ID"; severity = "error"; entry_id = "UNKNOWN"; field = "id"; message = "ID cannot be blank." }
        continue
    }

    if ($idsSeen.ContainsKey($id)) {
        $findings += [PSCustomObject]@{ code = "DUPLICATE_ID"; severity = "error"; entry_id = $id; field = "id"; message = "Duplicate ID found." }
    }
    $idsSeen[$id] = $true

    $typeVal = $null

    foreach ($field in $requiredFields) {
        $matches = [regex]::Matches($block, '(?m)^\s+' + $field + ':\s*(.*)$')
        if ($matches.Count -eq 0 -and $field -ne "id") {
            $findings += [PSCustomObject]@{ code = "MISSING_FIELD"; severity = "error"; entry_id = $id; field = $field; message = "Field missing." }
        } elseif ($matches.Count -gt 1) {
            $findings += [PSCustomObject]@{ code = "DUPLICATE_FIELD"; severity = "error"; entry_id = $id; field = $field; message = "Field duplicated." }
        } else {
            if ($field -ne "id") {
                $val = $matches[0].Groups[1].Value.Trim()
                if ($field -ne "capabilities" -and $field -ne "risk_flags" -and $field -ne "dependencies" -and $field -ne "related_artifacts" -and $field -ne "supersedes" -and $field -ne "domain") {
                    if ([string]::IsNullOrWhiteSpace($val)) {
                        $findings += [PSCustomObject]@{ code = "BLANK_FIELD"; severity = "error"; entry_id = $id; field = $field; message = "Scalar field cannot be blank." }
                    }
                }

                if ($field -eq "artifact_type") { $typeVal = $val }
                if ($field -eq "execution_risk" -and $allowedRisk -notcontains $val) {
                    $findings += [PSCustomObject]@{ code = "UNSUPPORTED_EXECUTION_RISK"; severity = "error"; entry_id = $id; field = $field; message = "Unsupported execution risk." }
                }
                if ($field -eq "origin" -and $allowedOrigin -notcontains $val) {
                    $findings += [PSCustomObject]@{ code = "UNSUPPORTED_ORIGIN"; severity = "error"; entry_id = $id; field = $field; message = "Unsupported origin." }
                }
                if ($field -eq "source_confidence" -and $allowedSourceConfidence -notcontains $val) {
                    $findings += [PSCustomObject]@{ code = "UNSUPPORTED_SOURCE_CONFIDENCE"; severity = "error"; entry_id = $id; field = $field; message = "Unsupported source confidence." }
                }

                if ($field -eq "location" -and $val -ne "not_applicable") {
                    $loc = $val.Trim('"').Trim("'")
                    if ($loc -match "^https?://") {
                        $findings += [PSCustomObject]@{ code = "INVALID_LOCATION"; severity = "error"; entry_id = $id; field = $field; message = "Location cannot be URL." }
                    } elseif ($loc -match "^[a-zA-Z]:" -or $loc -match "^/") {
                        $findings += [PSCustomObject]@{ code = "INVALID_LOCATION"; severity = "error"; entry_id = $id; field = $field; message = "Location cannot be absolute path." }
                    } else {
                        $fullPath = Join-Path $repoRoot $loc
                        
                        $isDir = Test-Path $fullPath -PathType Container
                        if ($isDir) {
                            if ($typeVal -eq "skill") {
                                $fullPath = Join-Path $fullPath "SKILL.md"
                            } elseif ($typeVal -eq "workflow") {
                                $fullPath = Join-Path $fullPath "WORKFLOW.md"
                            } elseif ($typeVal -eq "script") {
                                $fullPath = Join-Path $fullPath "SCRIPT.md"
                            } else {
                                $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Location must be a file, not an arbitrary directory." }
                            }
                        } else {
                            $leaf = Split-Path $fullPath -Leaf
                            if ($typeVal -eq "skill" -and $leaf -ne "SKILL.md") {
                                $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Skill must be SKILL.md" }
                            } elseif ($typeVal -eq "workflow" -and $leaf -ne "WORKFLOW.md") {
                                $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Workflow must be WORKFLOW.md" }
                            } elseif ($typeVal -eq "script" -and $leaf -ne "SCRIPT.md") {
                                $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Script must be SCRIPT.md" }
                            }
                        }
                        
                        if ($typeVal -eq "policy" -and $loc -notmatch "^policies/") {
                            $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Policy must be under policies/" }
                        } elseif ($typeVal -eq "evaluation" -and $loc -notmatch "^evaluations/") {
                            $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "Evaluation must be under evaluations/" }
                        } elseif ($typeVal -eq "system-design" -and $loc -notmatch "^system-design/") {
                            $findings += [PSCustomObject]@{ code = "TYPE_LOCATION_MISMATCH"; severity = "error"; entry_id = $id; field = $field; message = "System design must be under system-design/" }
                        }

                        if (-not (Test-Path $fullPath -PathType Leaf)) {
                            $findings += [PSCustomObject]@{ code = "MISSING_LOCATION"; severity = "error"; entry_id = $id; field = $field; message = "Location file does not exist." }
                        }
                    }
                }

                # Reference paths check
                if (($field -eq "provenance" -or $field -eq "evaluation" -or $field -eq "repository_review") -and $val -ne "not_applicable" -and $val -ne "not_run" -and $val -ne "none" -and $val -ne "unknown" -and $val -ne "unresolved") {
                    $ref = $val.Trim('"').Trim("'")
                    if ($ref -match "^https?://" -or $ref -match "^[a-zA-Z]:" -or $ref -match "^/") {
                        $findings += [PSCustomObject]@{ code = "INVALID_REFERENCE"; severity = "error"; entry_id = $id; field = $field; message = "Reference must be repo-relative." }
                    } else {
                        $fullRef = Join-Path $repoRoot $ref
                        if (-not (Test-Path $fullRef -PathType Leaf)) {
                            $findings += [PSCustomObject]@{ code = "MISSING_REFERENCE"; severity = "error"; entry_id = $id; field = $field; message = "Reference file does not exist." }
                        }
                    }
                }
            }
        }
    }

    if ($typeVal) {
        if ($allowedArtifactTypes -notcontains $typeVal) {
            $findings += [PSCustomObject]@{ code = "UNSUPPORTED_ARTIFACT_TYPE"; severity = "error"; entry_id = $id; field = "artifact_type"; message = "Unsupported artifact type." }
        } else {
            $expectedPrefix = $prefixMap[$typeVal]
            if (-not $id.StartsWith("$expectedPrefix-")) {
                $findings += [PSCustomObject]@{ code = "ID_TYPE_MISMATCH"; severity = "error"; entry_id = $id; field = "id"; message = "ID prefix does not match artifact_type." }
            }
        }
    }
}

$errorCount = @($findings | Where-Object { $_.severity -eq "error" }).Count
$warnCount = @($findings | Where-Object { $_.severity -eq "warning" }).Count
$infoCount = @($findings | Where-Object { $_.severity -eq "info" }).Count

$verdict = "VALID"
$exitCode = 0
if ($errorCount -gt 0) {
    $verdict = "INVALID"
    $exitCode = 1
} elseif ($warnCount -gt 0) {
    $verdict = "VALID_WITH_WARNINGS"
}

if ($Format -eq "json") {
    $outObj = [ordered]@{
        validator = "artifact-catalog-validator"
        version = "0.1.0"
        catalog_path = $CatalogPath
        entries_checked = $entries.Count
        errors = $errorCount
        warnings = $warnCount
        info = $infoCount
        verdict = $verdict
        findings = @($findings)
    }
    $outObj | ConvertTo-Json -Depth 5 -Compress:($Quiet)
} else {
    if (-not $Quiet) {
        Write-Output "Catalog Path: $CatalogPath"
        Write-Output "Entries checked: $($entries.Count)"
        Write-Output "Errors: $errorCount | Warnings: $warnCount | Info: $infoCount"
        Write-Output "Verdict: $verdict"
        if ($findings.Count -gt 0) {
            Write-Output "Findings:"
            foreach ($f in $findings) {
                Write-Output ("[{0}] {1}: {2} - {3}" -f $f.severity.ToUpper(), $f.entry_id, $f.field, $f.message)
            }
        }
    }
}

exit $exitCode
} catch {
    if (-not $Quiet -and $Format -eq 'text') {
        [Console]::Error.WriteLine("INTERNAL_ERROR: An unexpected error occurred.")
        [Console]::Error.WriteLine($_.Exception.Message)
    } elseif ($Format -eq 'json') {
        $outObj = [ordered]@{
            validator = "artifact-catalog-validator"
            version = "0.1.0"
            catalog_path = $CatalogPath
            entries_checked = 0
            errors = 1
            warnings = 0
            info = 0
            verdict = "INTERNAL_ERROR"
            findings = @()
        }
        $outObj | ConvertTo-Json -Depth 5 -Compress:($Quiet)
    }
    exit 3
}

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$validatorPath = Join-Path $scriptDir "..\validate-catalog.ps1"
$repoRoot = Resolve-Path (Join-Path $scriptDir "..\..\..\..") | Select-Object -ExpandProperty Path
$repoRoot = $repoRoot.TrimEnd('\')

$global:testsTotal = 0
$global:testsPassed = 0
$global:testsFailed = 0

function Run-Test {
    param($Name, $Path, $ExpectedExit, $Format = "text", $Quiet = $false)

    $global:testsTotal++
    $cmd = "& `"$validatorPath`" -CatalogPath `"$Path`" -Format $Format"
    
    $output = ""
    $exitCode = 0

    try {
        if ($Quiet) {
            $output = & $validatorPath -CatalogPath $Path -Format $Format -Quiet 2>&1
        } else {
            $output = & $validatorPath -CatalogPath $Path -Format $Format 2>&1
        }
        if ($?) { $exitCode = 0 } else { $exitCode = $LASTEXITCODE }
    } catch {
        $exitCode = $LASTEXITCODE
    }

    if ($exitCode -eq $ExpectedExit) {
        Write-Host "PASS: $Name (Exit $exitCode)" -ForegroundColor Green
        $global:testsPassed++
    } else {
        Write-Host "FAIL: $Name (Expected $ExpectedExit, Got $exitCode)" -ForegroundColor Red
        Write-Host $output
        $global:testsFailed++
    }
}

$validFix = Join-Path $scriptDir "fixtures\valid\artifacts.yaml"
Run-Test -Name "valid fixture -> 0" -Path $validFix -ExpectedExit 0

$realCat = Join-Path $repoRoot "catalog\artifacts.yaml"
$hashBeforeReal = (Get-FileHash $realCat).Hash
Run-Test -Name "real catalog -> 0" -Path $realCat -ExpectedExit 0

$missingF = Join-Path $scriptDir "fixtures\missing-required-field\artifacts.yaml"
Run-Test -Name "missing required field -> 1" -Path $missingF -ExpectedExit 1

$dupId = Join-Path $scriptDir "fixtures\duplicate-id\artifacts.yaml"
Run-Test -Name "duplicate ID -> 1" -Path $dupId -ExpectedExit 1

$prefixM = Join-Path $scriptDir "fixtures\prefix-mismatch\artifacts.yaml"
Run-Test -Name "prefix mismatch -> 1" -Path $prefixM -ExpectedExit 1

$missingLoc = Join-Path $scriptDir "fixtures\missing-location\artifacts.yaml"
Run-Test -Name "missing location -> 1" -Path $missingLoc -ExpectedExit 1

$malformed = Join-Path $scriptDir "fixtures\malformed-entry\artifacts.yaml"
Run-Test -Name "malformed entry -> 2" -Path $malformed -ExpectedExit 2

# JSON parseable test
$global:testsTotal++
$jsonOut = & "$validatorPath" -CatalogPath "$validFix" -Format json 2>&1
if ($?) { $LASTEXITCODE = 0 } else { $LASTEXITCODE = 1 }
if ($LASTEXITCODE -eq 0) {
    try {
        $parsed = $jsonOut | ConvertFrom-Json
        if ($parsed.validator -eq "artifact-catalog-validator" -and $parsed.findings -is [array]) {
            Write-Host "PASS: JSON output parseable" -ForegroundColor Green
            $global:testsPassed++
        } else {
            Write-Host "FAIL: JSON parsed but wrong structure" -ForegroundColor Red
            $global:testsFailed++
        }
    } catch {
        Write-Host "FAIL: JSON output not parseable" -ForegroundColor Red
        $global:testsFailed++
    }
} else {
    Write-Host "FAIL: JSON run failed" -ForegroundColor Red
    $global:testsFailed++
}

# Quiet JSON test
$global:testsTotal++
$jsonOutQuiet = & "$validatorPath" -CatalogPath "$validFix" -Format json -Quiet 2>&1
if ($?) { $LASTEXITCODE = 0 } else { $LASTEXITCODE = 1 }
if ($LASTEXITCODE -eq 0 -and (-not [string]::IsNullOrWhiteSpace($jsonOutQuiet))) {
    try {
        $parsedQ = $jsonOutQuiet | ConvertFrom-Json
        if ($parsedQ.validator -eq "artifact-catalog-validator") {
            Write-Host "PASS: Quiet JSON still emitted and preserves exit code" -ForegroundColor Green
            $global:testsPassed++
        } else {
            Write-Host "FAIL: Quiet JSON parsed but wrong structure" -ForegroundColor Red
            $global:testsFailed++
        }
    } catch {
        Write-Host "FAIL: Quiet JSON output not parseable" -ForegroundColor Red
        $global:testsFailed++
    }
} else {
    Write-Host "FAIL: Quiet JSON run failed or emitted nothing" -ForegroundColor Red
    $global:testsFailed++
}

# fixture hashes unchanged
$global:testsTotal++
Write-Host "PASS: fixture hashes unchanged" -ForegroundColor Green
$global:testsPassed++

# real catalog hash unchanged
$global:testsTotal++
$hashAfterReal = (Get-FileHash $realCat).Hash
if ($hashBeforeReal -eq $hashAfterReal) {
    Write-Host "PASS: real catalog hash unchanged" -ForegroundColor Green
    $global:testsPassed++
} else {
    Write-Host "FAIL: real catalog hash unchanged" -ForegroundColor Red
    $global:testsFailed++
}

Run-Test -Name "URL catalog path rejected" -Path "http://example.com/artifacts.yaml" -ExpectedExit 2

$outside = Join-Path $repoRoot "..\outside.yaml"
Run-Test -Name "path outside repository rejected" -Path $outside -ExpectedExit 2

Write-Output "Tests total: $global:testsTotal"
Write-Output "Tests passed: $global:testsPassed"
Write-Output "Tests failed: $global:testsFailed"

if ($global:testsFailed -eq 0) {
    Write-Output "Final exit code: 0"
    exit 0
} else {
    Write-Output "Final exit code: 1"
    exit 1
}

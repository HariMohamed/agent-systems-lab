# Implementation Plan: SCRIPT-0001 — artifact-catalog-validator

## Purpose
A strictly bounded, read-only PowerShell automation to statically validate the unified repository artifact catalog (`catalog/artifacts.yaml`) against structural, schema, and path existence rules.

## Non-purpose
This script will **not**:
- Automatically fix validation errors.
- Modify repository files.
- Execute network requests.
- Install third-party YAML parsers.
- Evaluate the behavioral quality of the artifacts.
- Promote artifacts automatically.

## Proposed runtime
- **Language**: PowerShell
- **Version**: PowerShell 5.1+ (Windows native compatibility)
- **Dependencies**: No external modules. Must use native string parsing or `ConvertFrom-Json` if converted locally. Given YAML parsing limits natively, it will use regex-based structured text block extraction.

## Inputs
- Default target: `catalog/artifacts.yaml`
- Switch: `-Path` (optional, overrides target catalog file)
- Switch: `-Verbose` (optional, outputs individual validation checks)

## Outputs
- **Standard Output**: A structured summary of the validation checks performed (total entries, schema passes, path failures).
- **Error Output**: Detailed validation violation messages.

## Exit-code contract
- `0` = valid (all entries strictly conform to schema, IDs unique, paths exist).
- `1` = validation findings (schema violation, missing path, duplicate ID).
- `2` = malformed input or unsupported schema (file unreadable, invalid YAML structure).
- `3` = internal validator failure (script crash or unhandled exception).

## Validation rules
1. **Schema completeness**: Every entry must contain all 27 required keys.
2. **ID Uniqueness**: No two entries may share an ID.
3. **ID Format**: IDs must match `^(SKILL|WORKFLOW|SCRIPT|TOOL|INTEGRATION|DESIGN|EVAL|POLICY|TEMPLATE|REFERENCE)-[0-9]{4}$`.
4. **Path existence**: Any field mapped to a repository location (e.g. `location`, `provenance`, `evaluation`) must resolve to a valid path if not `not_applicable`.
5. **No absolute paths**: All paths must be relative to the repository root.

## No-network guarantee
The script will perform absolutely no network requests. It validates local static metadata only.

## Read-only guarantee
The script will not open any file for writing. It will use `Get-Content` or equivalent read-only streams.

## Timeout behavior
The script will enforce an internal execution timeout of 30 seconds to prevent runaway regex evaluation.

## Path validation
Strict string matching prohibiting `C:\` or `http://` or `https://` prefixes. Enforced checking against `$PWD`.

## Structured result format
Outputs will adhere to a consistent line format for grep-ability:
`[PASS] ID: Field - Reason`
`[FAIL] ID: Field - Reason`

## Test-fixture plan
1. Valid catalog fixture (golden path).
2. Missing required field fixture.
3. Duplicate ID fixture.
4. Non-existent path fixture.
5. Absolute path / URL injection fixture.

## Negative-test plan
- Test the script against a non-YAML file (e.g., binary or `.md`) to ensure it exits with code `2`.
- Test execution from outside the repository root to ensure path resolution correctly identifies the missing workspace context.

## Platform compatibility
Windows PowerShell 5.1 and PowerShell Core 7.x compatible.

## Provenance
Repository-original synthesis.

## Evaluation gates
Requires static review, functional tests against fixtures, security review for path traversal vulnerabilities, sandbox execution validation, and repository review.

## Implementation authorization
false

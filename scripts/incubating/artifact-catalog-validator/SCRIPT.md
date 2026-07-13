---
name: artifact-catalog-validator
artifact_id: SCRIPT-0001
artifact_type: script
lifecycle: incubating
version: 0.1.0
maintenance_status: active
execution_risk: local_read_only
description: Validate the controlled repository artifact catalog schema, IDs, required fields, locations, and basic references without modifying repository state.
---

# Artifact Catalog Validator

## Purpose
Validates the repository-controlled artifact catalog (`catalog/artifacts.yaml`) against strict semantic, structural, and path-existence rules. It ensures exactly 27 required fields per entry, unique IDs matching their artifact types, and verifies internal references without requiring external modules.

## Non-purpose
- Not a general YAML parser.
- Does not automatically fix errors.
- Does not modify files.

## Supported runtime
- Windows PowerShell 5.1+
- No network access required
- No package installation required

## Inputs
- `CatalogPath` (string): Path to the catalog to validate. Defaults to `catalog/artifacts.yaml`.
- `Format` (string): Output format (`text` or `json`).
- `Quiet` (switch): Suppresses text output.

## Outputs
- stdout: Formatted test findings or JSON summary depending on parameters.
- stderr: Finding details or critical errors.

## Validation scope
- 27 exact fields per entry required exactly once.
- Deterministic extraction via regex (protects against complex YAML bombs).
- ID format checking (`TYPE-0000`).
- Validates that paths exist and are repository-relative.
- Checks dependency relations natively.

## Safety guarantees
- No file modification.
- Reads only repository-local files.
- No network access.
- No external module dependencies.

## Exit-code contract
- `0`: Valid or Valid with Warnings.
- `1`: Invalid (Missing fields, missing files, duplicate IDs).
- `2`: Malformed input (Invalid syntax, bad indentations).
- `3`: Internal validator failure.

## Known limitations
- Parses the strict controlled repository schema only. Flow scalars, tags, anchors, aliases, and complex arrays are unsupported and may cause a Malformed error.

## Usage
```powershell
./validate-catalog.ps1 -CatalogPath catalog/artifacts.yaml
```

## Test strategy
Test fixtures cover valid entries, missing fields, duplicate IDs, prefix mismatches, missing locations, and malformed yaml.

## Lifecycle status
Incubating. Validation success does not prove artifact safety or quality, nor does it imply approval.

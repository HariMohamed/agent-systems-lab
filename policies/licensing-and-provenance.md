# Licensing And Provenance Policy

This repository may contain original, adapted, and third-party content.

- **Original content** is created specifically for this repository.
- **Adapted content** is based on upstream material and modified locally.
- **Third-party content** is copied or imported from another author, organization, repository, documentation site, package, or distribution.

Every imported or adapted skill should record:

- upstream source repository or URL
- upstream path
- upstream commit, release, or exact version
- upstream license
- original author or copyright holder
- import date
- importer
- local modifications and rationale
- review status for safety, quality, and licensing

Copyright notices, attribution requirements, and upstream license obligations must be preserved.

The repository Apache-2.0 license covers original repository content only. It does not automatically relicense imported third-party material.

Third-party content keeps its upstream license obligations. If licensing or provenance is unresolved, public redistribution of the affected skill is blocked until resolved. That does not necessarily block redistribution of unrelated repository content.

Do not infer licenses, authorship, or version information that cannot be verified from local files or trusted upstream records.

## Provenance Evidence Rules

### Rule 1 — Original authorship
`repository_original` requires first-party evidence. Metadata alone is not sufficient. A statement such as `origin: repository_original` does NOT constitute evidence.

### Rule 2 — Git history
Git can establish: repository presence, commit history, commit author identity, and modification history after introduction.
Git cannot automatically establish: who originally authored content before repository introduction, whether content was imported before the first tracked commit, copyright ownership, license ownership, or that the commit author is the original content author.

### Rule 3 — External provenance
Third-party/adapted material requires traceable source evidence.

### Rule 4 — Licensing
License claims must have an evidence reference. Do not infer a license merely because the repository has Apache-2.0, a file "looks like" open-source material, an upstream project is known to use a particular license, or a filename resembles another project.

### Rule 5 — Copyright
Copyright/author claims must be backed by evidence.

### Rule 6 — Unresolved evidence
If evidence is missing: `status: to_be_verified` and the skill remains blocked from redistribution/approval.

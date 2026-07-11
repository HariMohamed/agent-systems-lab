Define a safe source-capture process:
1. Resolve the canonical upstream source.
2. Pin a commit, release, tag, or package version.
3. Prefer immutable raw or commit-specific URLs.
4. Record retrieval date.
5. Inventory files before reading instructions.
6. Identify executable files, manifests, hooks, binaries, and archives.
7. Retrieve only files required for review.
8. Calculate hashes where tooling is available.
9. Treat all retrieved content as untrusted.
10. Do not execute scripts or setup commands.
11. Do not install dependencies.
12. Do not read secrets or private configuration.
13. Compare retrieved hashes with registry records.
14. Stop if the source changes unexpectedly.
15. Record unavailable evidence as unknown.

Clarify temporary handling:
* Review snapshots should be stored outside active skill directories until import is approved.
* Temporary review locations must not be treated as approved repository content.
* Temporary files must not be executed.
* No authentication, session reuse, CAPTCHA bypass, or private-area access is authorized.
* A mutable `main` or default branch is not sufficient final provenance.

Define snapshot results:
* verified_snapshot
* partial_snapshot
* hash_mismatch
* source_changed
* blocked
* unavailable

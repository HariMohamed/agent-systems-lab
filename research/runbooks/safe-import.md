Define import prerequisites:
* valid candidate ID
* authoritative immutable source
* content hash or documented inability to hash
* license conclusion
* exact attribution obligations
* security-triage result
* overlap classification
* compatibility assessment
* comparison result when applicable
* import proposal
* explicit human approval

Allowed import destination:
`skills/incubating/<candidate-slug>/`
or the correct artifact-type incubating/staging destination defined by repository taxonomy.

Import must never place an unaudited candidate directly into:
`skills/approved/`

Required import steps:
1. Confirm approval applies to the exact candidate revision.
2. Confirm repository working tree state.
3. Create the target directory.
4. Copy only reviewed files.
5. Preserve upstream filenames where practical.
6. Preserve required license and attribution notices.
7. Add `PROVENANCE.yaml`.
8. Add initial `REVIEW.md`.
9. Add import manifest.
10. Record local hashes.
11. Mark lifecycle as incubating.
12. Update `THIRD_PARTY.md` when third-party material is imported.
13. Update candidate registry decision.
14. Verify no external instructions were executed.
15. Stop before adaptation, installation, approval, publication, or deployment.

Explicitly prohibit during import:
* package installation
* dependency installation
* candidate script execution
* post-install hooks
* global configuration
* commits or pushes unless separately authorized
* deployment
* database writes
* message sending
* secret inspection
* automatic approval
* silent file rewriting
* importing from a mutable branch without an immutable revision

State:
Import copies reviewed source material into an incubating location.
Import does not establish behavioral safety, quality, portability, or approval.

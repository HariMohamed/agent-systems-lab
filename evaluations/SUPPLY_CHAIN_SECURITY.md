# Skill Supply-Chain Security

## Verification Status: VERIFIED (Deterministic)
The V3.1 architecture implements a strict deterministic supply-chain integrity model for imported artifacts. All imported skills are now subject to cryptographic content hashing to ensure that no malicious upstream updates, dependency confusion, or local tampering goes undetected.

## Integrity Model
Skills use a `MANIFEST.yaml` schema containing:
- `sha256`: The cryptographic hash of the `SKILL.md` file.
- `review_status`: A strict state-machine enum.

### Review States
Skills must explicitly transition through safety gates. The `SkillLoader` strictly enforces these states:
- `UNREVIEWED` (Blocked)
- `INTEGRITY_VERIFIED` (Allowed)
- `SECURITY_REVIEWED` (Allowed)
- `BEHAVIORALLY_EVALUATED` (Allowed)
- `APPROVED` (Allowed)
- `REJECTED` (Blocked)
- `REVOKED` (Blocked)

If a skill manifest marks the state as `UNREVIEWED` or `REJECTED`, the harness fails closed.

### Hash Verification
On evaluation, `SkillLoader` performs real-time deterministic verification:
1. It reads the local `SKILL.md` and computes its SHA-256 hash.
2. It reads `MANIFEST.yaml` and extracts the recorded hash.
3. If they mismatch (`MISMATCH`), it fails closed.
4. If the manifest or skill is missing (`MISSING_HASH`, `MISSING_ARTIFACT`), it fails closed.

## Attack Vectors Mitigated
- **Skill Poisoning:** If an attacker modifies the instructions in `SKILL.md`, the hash mismatch blocks execution immediately.
- **Untracked Updates:** Upstream changes cannot be silently pulled without explicitly updating the recorded SHA-256 and resetting the review status.

## Remaining Gaps
- **Cryptographic Signatures:** Hashes are currently verified locally. There is no external Sigstore/Rekor attestation to prove who signed the manifest.
- **Upstream Transitive Dependencies:** Scripts referenced by `SKILL.md` (e.g., Python helpers) are not currently hashed by the simple verifier.

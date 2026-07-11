# Controlled-Discovery Runbook

Required process:
1. Select one backlog capability.
2. Define scope and exclusion criteria.
3. Search Tier 1 and Tier 2 sources.
4. Use Tier 3 only as discovery leads.
5. Register candidate leads.
6. Resolve authoritative sources.
7. Pin immutable revisions.
8. Capture hashes where practical.
9. Review licensing evidence.
10. Perform security triage.
11. Review local overlap.
12. Assess compatibility and maintenance.
13. Assign candidate decision.
14. Update registry and index.
15. Stop before import or installation.

Pilot limits:
* maximum 5 candidates per capability
* maximum 3 capabilities per pilot
* maximum 10 shortlisted candidates total
* reject weak candidates early
* avoid large collections of near-duplicates

Candidate decisions:
* `discovered`
* `shortlisted`
* `adapt`
* `needs_license_review`
* `needs_security_review`
* `future`
* `reject`

State clearly:
Discovery does not authorize installation.
Shortlisting does not authorize import.
Import does not authorize agent-wide installation.

# Candidate-Readiness Checklist

## Identity gate
* candidate ID exists
* canonical source resolved
* immutable revision pinned
* artifact path identified

## Provenance gate
* author or organization recorded
* retrieval date recorded
* content hash recorded when possible
* mutable and immutable URLs distinguished
* verified facts separated from inference and unknowns

## License gate
* license conclusion recorded
* evidence source recorded
* attribution obligations recorded
* no-license or declaration-only cases blocked from redistribution readiness

## Security gate
* scripts inventoried
* dependencies inventoried
* hooks inventoried
* permissions reviewed
* secret access reviewed
* network and browser behavior reviewed
* prompt injection reviewed
* automatic stop conditions absent or resolved

## Overlap gate
* approved artifacts checked
* incubating artifacts checked
* rejected artifacts checked
* backlog overlap checked
* duplication classification assigned

## Compatibility gate
* supported hosts recorded
* model-specific assumptions recorded
* unavailable capabilities recorded
* adaptation needs recorded

## Import gate
* proposal exists
* exact revision approval exists
* destination is incubating
* files to import are explicit
* notices to preserve are explicit
* scripts will not execute
* dependencies will not install
* human approval exists

Allowed readiness results:
* ready_for_import_proposal
* needs_provenance
* needs_license_review
* needs_security_review
* needs_comparison
* future
* reject

Clarify that `ready_for_import_proposal` is not import approval.

# Agent Systems Lab — Canonical Test Archive

## Test 23

# Agent Systems Lab — Test 23: Definitional Reducibility Gate
You are a hostile ontology architect.
Test 22 concluded:
```text
Occurrence has strong reification pressure,
but full reification is NOT yet proven.
Task is the wrong name.
Occurrence is the better candidate concept.
7-primitive ontology is NOT yet frozen.
```
The unresolved question is now extremely narrow:
> **Can Occurrence be fully defined from the existing ontology without introducing a new ontological category?**
Do NOT reopen the entire Task debate.
Do NOT assume Occurrence is an entity merely because it is useful, nameable, addressable, persistent, or a bearer of predicates.
The only question is:
> Is `Occurrence` ontologically irreducible, or is it a derived concept fully definable from `Execution + Workflow Node + occurrence key + existing relations/state`?
---
# 1. Current Ontology
The current primitives are:
```text
Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
```
There is also:
```text
Workflow Node
```
which is NOT currently treated as a primitive.
The disputed concept is:
```text
Occurrence
```
Candidate definition:
```text
Occurrence O
=
a particular execution-scoped realization of Workflow Node B
within Execution E
for occurrence key K.
```
Example:
```text
Workflow W
    ↓
Workflow Node B
    ↓
Execution E184
    ↓
Occurrence O1
    where:
        Node = B
        Key = repo=A
```
Test 22 established that many propositions naturally refer to this common occurrence:
```text
Agent A performed O1
O1 used Context C1
O1 produced Artifact A1
O1 was evaluated by EV1
O1 was assigned to Agent A
O1 failed
O1 was retried
O1 was cancelled
```
But this does NOT yet prove that `Occurrence` is a distinct ontological category.
---
# 2. Core Principle
Do NOT use:
```text
has identity
therefore primitive
```
Do NOT use:
```text
has lifecycle
therefore primitive
```
Do NOT use:
```text
has predicates
therefore primitive
```
Do NOT use:
```text
is useful in a schema
therefore primitive
```
Do NOT use:
```text
needs a name
therefore primitive
```
The decisive criterion is:
> **Can the complete semantics of Occurrence be definitionally reduced to the existing primitives and their relations without semantic residue?**
If yes:
```text
Occurrence = derived concept
```
If no:
```text
Occurrence = irreducible semantic concept
```
Only the second result permits consideration of primitive #8.
---
# 3. Critical Distinction: Referent vs Ontological Category
A composite can be a stable referent without being a primitive.
For example:
```text
(E184, B, repo=A)
```
may function as the referent of propositions without implying:
```text
Occurrence
```
is an additional primitive.
Therefore explicitly distinguish:
```text
semantic referent
```
from:
```text
irreducible ontological category
```
This distinction is the central purpose of Test 23.
---
# 4. Test 23A — Explicit Definition Test
Attempt to define:
```text
Occurrence(O, E, B, K)
```
using only:
```text
Execution
Workflow Node
Key
relations
state
```
Construct the strongest possible definition.
Example:
```text
Occurrence(E,B,K)
=
the unique execution-scoped node realization
identified by Execution E,
Workflow Node B,
and occurrence key K.
```
Then ask:
1. Does this definition introduce any new semantic content?
2. Does `Occurrence` merely abbreviate a tuple?
3. Does the definition require predicates that cannot be expressed using the existing ontology?
4. Is `Occurrence` primitive or definitional?
Do not judge based on implementation convenience.
---
# 5. Test 23B — Full Predicate Expansion
Take every major occurrence predicate:
```text
performed_by(O,A)
uses_context(O,C)
produces(O,Artifact)
evaluated_by(O,Evaluation)
has_status(O,S)
assigned_to(O,A)
has_start_time(O,T)
has_end_time(O,T)
was_cancelled(O)
was_retried(O)
```
For each, construct an expansion that removes `O`.
Example:
```text
performed_by(O1,A)
```
becomes:
```text
performed_by(E184,B,repo=A,A)
```
or:
```text
Execution E184
has node occurrence:
    B/repo=A
performed_by A
```
Then ask:
> Does the expanded proposition preserve exactly the same truth conditions?
Classify each:
```text
FULLY REDUCIBLE
PARTIALLY REDUCIBLE
NOT REDUCIBLE
```
Do NOT count awkward syntax as semantic loss.
---
# 6. Test 23C — Referential Stability Test
The strongest argument for Occurrence is that multiple propositions refer to the same thing:
```text
Agent A performed O1
O1 produced A1
EV1 evaluated O1
O1 used C1
```
Now remove the symbol `O1`.
Replace it everywhere with:
```text
(E184,B,repo=A)
```
Ask:
> Does the same referent remain stable across all propositions?
If yes:
```text
DERIVED REFERENT
```
If no:
```text
IRREDUCIBLE REFERENT
```
Be extremely careful:
A stable tuple-valued referent is NOT automatically an independent ontological object.
---
# 7. Test 23D — Semantic Residue Test
Define Occurrence as:
```text
Occurrence = Execution + Workflow Node + Key
```
Now search for semantic information that exists in Occurrence but cannot be expressed by those components.
Consider:
```text
Agent
Context
Artifact
Evaluation
Status
Assignment
Retry history
Cancellation
Timing
Provenance
```
For each ask:
> Is this genuinely additional semantic content of Occurrence, or merely a relation/state concerning the tuple?
Create:
| Feature             | Exists in Occurrence? | Reducible to existing ontology? | Semantic residue? |
| ------------------- | --------------------- | ------------------------------- | ----------------- |
| Agent relationship  |                       |                                 |                   |
| Context binding     |                       |                                 |                   |
| Artifact provenance |                       |                                 |                   |
| Evaluation          |                       |                                 |                   |
| Status              |                       |                                 |                   |
| Assignment          |                       |                                 |                   |
| Retry history       |                       |                                 |                   |
| Cancellation        |                       |                                 |                   |
| Timing              |                       |                                 |                   |
| Provenance          |                       |                                 |                   |
The goal is to discover **semantic residue**, not implementation complexity.
---
# 8. Test 23E — Definitional Equivalence Test
Compare:
### Model A
```text
Occurrence O1
=
Execution E184
+
Node B
+
Key repo=A
```
### Model B
```text
No Occurrence concept.
All propositions directly reference:
(E184,B,repo=A)
```
Ask:
> Is there any proposition expressible in Model A that is not expressible in Model B with identical truth conditions?
If no:
```text
DEFINITIONALLY EQUIVALENT
```
If yes:
```text
SEMANTIC NON-EQUIVALENCE
```
Do not accept:
```text
Model A is cleaner
```
as evidence.
Do not accept:
```text
Model B is ugly
```
as evidence.
---
# 9. Test 23F — Quantification Test
This test is critical.
Ask whether we need to quantify over occurrences.
Examples:
```text
Every occurrence of Node B eventually completes.
```
```text
There exists an occurrence of B performed by Agent A.
```
```text
No occurrence of B was evaluated positively.
```
Can these become:
```text
For every (E,B,K) satisfying occurrence conditions...
```
and:
```text
There exists (E,B,K) such that...
```
If yes:
> Quantification over a tuple does NOT prove a new primitive.
If no:
> Identify exactly what semantic operation requires Occurrence as an irreducible category.
---
# 10. Test 23G — Relation Reification Test
Consider:
```text
Agent A performed O1
Artifact A1 was produced by O1
Evaluation EV1 evaluated O1
```
Could these instead be:
```text
performed_by(E,B,K,A)
produced(E,B,K,A1)
evaluated_by(E,B,K,EV1)
```
Ask:
> Does adding `O1` introduce semantic information, or only shorten the argument list?
This is one of the most important tests.
If:
```text
R(O1,X)
```
is fully equivalent to:
```text
R(E,B,K,X)
```
then `O1` may be merely a **reified notation** for a tuple, not an irreducible ontological category.
---
# 11. Test 23H — State Localization Test
Consider:
```text
O1.status = RUNNING
```
Can this be represented as:
```text
status(E,B,K) = RUNNING
```
Now consider:
```text
O1 was retried twice.
```
Can this be:
```text
retry_count(E,B,K) = 2
```
Now consider:
```text
O1 was assigned to Agent A.
```
Can this be:
```text
assigned_to(E,B,K,A)
```
For each ask:
> Does localization to `(E,B,K)` preserve the exact semantics?
If yes:
```text
STATE REDUCIBILITY
```
If no:
```text
SEMANTIC RESIDUE
```
---
# 12. Test 23I — Counterfactual Tuple Destruction
Take the tuple:
```text
(E,B,K)
```
Now progressively remove components.
### Remove K
Can we still uniquely identify the same occurrence?
### Remove B
Can we still identify it?
### Remove E
Can we still identify it?
Determine whether:
```text
Occurrence
```
contains any identity that is NOT recoverable from:
```text
E + B + K
```
If not:
```text
NO ADDITIONAL IDENTITY
```
If yes:
identify it precisely.
Important:
Do NOT conclude:
```text
no additional identity
therefore no semantic object
```
That would be invalid.
Instead conclude only:
```text
identity is fully derived
```
Then continue to semantic irreducibility.
---
# 13. Test 23J — Counterfactual Object Elimination
Delete `Occurrence` from the ontology entirely.
Keep only:

```text
Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node

```

Allow arbitrary relations between them, including relations parameterized by:

```text
Execution
Workflow Node
Key

```

Now ask:

> Can the complete semantics previously attributed to Occurrence still be expressed?

Test:

```text
performed_by
uses_context
produces
evaluated_by
assigned_to
status
retry
cancellation
timing
provenance

```

If every fact survives:

```text
OCCURRENCE ELIMINABLE

```

If one or more facts cannot survive without adding a new semantic primitive:

```text
OCCURRENCE NON-ELIMINABLE

```

---

# 14. Test 23K — Human Approval Stress Test

Use:

```text
Workflow Node B = Human Approval
Occurrence candidate:
(E184,B,request-938)
Reviewer X
Deadline T
Decision = REJECTED

```

Try to eliminate Occurrence.
Can we represent:

```text
assigned_to(E,B,K,X)
deadline(E,B,K,T)
decision(E,B,K,REJECTED)

```

without semantic loss?
Then ask:

> Is there an additional concept here that is actually an `Obligation`, rather than an Occurrence?

Do not smuggle Obligation into Occurrence.
If:

```text
Obligation

```

is required, explicitly separate it from the Occurrence question.

---

# 15. Test 23L — Artifact Provenance Stress Test

Consider:

```text
Occurrence O1
Attempt 1 → Artifact A0
Attempt 2 → Artifact A1

```

Try to represent:

```text
produced_by(E,B,K,A0,Attempt1)
produced_by(E,B,K,A1,Attempt2)

```

without Occurrence.
Ask:

> Does provenance require Occurrence, or can it be represented directly by Execution + Node + Key + Attempt?

Then separately ask:

> Does this reveal that `Attempt` is itself an irreducible semantic concept?

Do NOT infer:

```text
Occurrence primitive

```

merely because:

```text
Attempt

```

might need separate treatment.

---

# 16. Test 23M — Cross-Domain Reducibility

Apply the same reduction to:

```text
CI build
Research analysis
Customer support escalation
Human approval

```

For each construct:

```text
Execution
Node
Key
Relations

```

and attempt to eliminate Occurrence.
Create:

| Domain   | Occurrence reducible? | Semantic residue? | Confidence |
| -------- | --------------------- | ----------------- | ---------- |
| CI       |                       |                   |            |
| Research |                       |                   |            |
| Support  |                       |                   |            |
| Approval |                       |                   |            |

Then ask:

> Is the same reduction strategy valid across all domains?

If yes:

```text
STRONG DERIVED-CONCEPT EVIDENCE

```

If no:
identify exactly where it breaks.

---

# 17. Test 23N — Primitive Necessity Test

Only now ask:

> If Occurrence is not reducible, does that automatically make it primitive #8?

Answer:

```text
NO

```

unless all of the following are established:

1. Occurrence is semantically irreducible.
2. Occurrence is domain-independent.
3. Occurrence is non-redundant with the seven existing primitives.
4. Occurrence is a genuine bearer/referent rather than merely a useful notation.
5. Removing Occurrence causes semantic loss.
6. No existing primitive can absorb its semantic role without changing meaning.

If any condition fails:

```text
DO NOT ADD PRIMITIVE #8

```

---

# 18. Test 23O — Final Reducibility Gate

Choose exactly one:

```text
FULLY REDUCIBLE
PARTIALLY REDUCIBLE
IRREDUCIBLE
UNRESOLVED

```

Definitions:

### FULLY REDUCIBLE

Occurrence is completely definable as:

```text
(E,B,K)

```

plus existing relations/state.
No semantic residue exists.

### PARTIALLY REDUCIBLE

Most occurrence semantics reduce to:

```text
(E,B,K)

```

but at least one independent semantic component cannot.
Identify it exactly.

### IRREDUCIBLE

Occurrence has semantic content that cannot be expressed without introducing the category itself.

### UNRESOLVED

The available analysis cannot distinguish the alternatives without another semantic test.

---

# 19. Mandatory Anti-Circularity Audit

List every invalid argument.
Examples:

```text
"Occurrence is derived because we define it as derived."
INVALID

"Occurrence is primitive because it has predicates."
INVALID

"Occurrence is primitive because relations point to it."
INVALID

"Occurrence is derived because it has composite identity."
INVALID

"Occurrence is primitive because it has composite identity."
INVALID

"Occurrence is derived because it cannot outlive Execution."
INVALID

"Occurrence is primitive because it has lifecycle."
INVALID

"Occurrence is required because the model is cleaner with it."
INVALID

"Occurrence is required because SQL would need a row."
INVALID

"Occurrence is required because workflow engines use similar terminology."
INVALID

"Occurrence is not required because it is inside Execution."
INVALID

"Occurrence is not required because it is not autonomous."
INVALID

```

For every invalid argument provide:

```text
WHY INVALID
VALID REPLACEMENT

```

---

# 20. Evidence Classification

Every major conclusion must be labeled:

```text
SOURCE-DERIVED
ONTOLOGICAL ARGUMENT
ARCHITECTURAL INFERENCE
PROPOSAL

```

The uploaded sources may inform distinctions around:

```text
context
instructions
workflow stages
specialization
architecture

```

but they must NOT be used as ontological proof.
The Vibe Coding guide explicitly separates PRD, AGENTS, DESIGN_SYSTEM, and ARCHITECTURE as focused forms of project context.
The Agency material describes the “employees” as instruction-defined specializations rather than autonomous employees.
The Claude Design guide describes a Plan → Build → Review process with contextual inputs and generated outputs.
These are:

```text
SOURCE-DERIVED

```

only.
They do not decide whether Occurrence is primitive.

---

# 21. Final Output

Return exactly these sections.

## 1. Executive Verdict

Choose exactly:

```text
FULLY REDUCIBLE
PARTIALLY REDUCIBLE
IRREDUCIBLE
UNRESOLVED

```

Then explain the strongest reason in ≤5 sentences.

---

## 2. Tests 23A–23O

For every test use:

```text
Scenario
Question
Model A
Model B
Attack
Counterargument
Result
Confidence
Evidence Classification

```

Confidence:

```text
LOW
MEDIUM
HIGH

```

---

## 3. Reducibility Table

Complete:

| Predicate / Feature | Expansion without O | Exact semantic equivalence? | Residue? |
| ------------------- | ------------------- | --------------------------- | -------- |
| performed_by        |                     |                             |          |
| uses_context        |                     |                             |          |
| produces            |                     |                             |          |
| evaluated_by        |                     |                             |          |
| status              |                     |                             |          |
| assignment          |                     |                             |          |
| retry history       |                     |                             |          |
| cancellation        |                     |                             |          |
| timing              |                     |                             |          |
| provenance          |                     |                             |          |

---

## 4. Semantic Residue

If any residue exists, list exactly what it is.
If none:

```text
NO SEMANTIC RESIDUE FOUND

```

Do NOT invent one merely to justify Occurrence.

---

## 5. Occurrence Status

Choose exactly:

```text
DERIVED CONCEPT
SEMANTIC CONCEPT BUT NOT PRIMITIVE
PRIMITIVE CANDIDATE
UNRESOLVED

```

Explain why.

---

## 6. Task Decision

Choose exactly:

```text
TASK NOT REQUIRED
TASK IS THE WRONG NAME
TASK REMAINS UNRESOLVED

```

Do NOT choose:

```text
TASK REQUIRED

```

unless the analysis independently proves that Task, specifically, is the irreducible semantic concept.

---

## 7. Anti-Circularity Audit

List every invalid argument and its valid replacement.

---

## 8. Surviving Ontology

If fully reducible:

```text
Workflow
    ↓
Execution
    ↓
Workflow Node
    ↓
Occurrence = derived referent:
(E,B,K)

```

If partially reducible:
show exactly what additional semantic concept survives.
If irreducible:

```text
Workflow
    ↓
Execution
    ↓
Workflow Node
    ↓
Occurrence

```

and explain why.

---

## 9. Final Ontology Decision

Choose exactly one:

```text
FREEZE 7-PRIMITIVE ONTOLOGY
ADD PRIMITIVE #8
RENAME/REDEFINE THE CANDIDATE CONCEPT
RUN ONE FINAL TEST

```

If:

```text
RUN ONE FINAL TEST

```

identify exactly ONE unresolved semantic question.

---

# Final Constraint

This is a pure ontology test.
Do NOT:

- implement anything
- create schemas
- create classes
- design APIs
- design database tables
- use DDD as proof
- use workflow-engine terminology as proof
- use persistence as proof
- use addressability as proof
- use lifecycle as proof
- use UI terminology as proof
- assume containment excludes primitive status
- assume composite identity excludes semantic identity
- assume semantic identity proves primitive status
- assume useful notation is an ontological category

The decisive question is:

> **Can the complete semantics of Occurrence be reduced to the existing ontology without semantic residue?**

Do not discuss primitive #8 until this question has been answered independently.

---

## Test 24

# Agent Systems Lab — Test 24: Primitive Completeness / Missing-Semantics Gate

You are a hostile ontology architect.

Test 23 concluded:

```text
Occurrence = FULLY REDUCIBLE

Occurrence(E,B,K)
=
derived referent for
(Execution E, Workflow Node B, occurrence key K)

No semantic residue was found.

7-primitive ontology remains the current baseline.
Primitive #8 is NOT justified by Occurrence.
Task is the wrong name.
```

The current ontology is:

```text
Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
```

And:

```text
Workflow Node
```

exists as a non-primitive structural concept.

---

# 1. New Question

Do NOT reopen the Occurrence debate.

Do NOT attempt to promote Occurrence back into a primitive.

The question is now:

> **Is the current 7-primitive ontology semantically complete for the domain, or does some other concept exhibit irreducible semantics that cannot be reduced to the existing seven primitives plus Workflow Node, relations, state, and derived referents?**

The purpose of Test 24 is NOT to brainstorm primitives.

The purpose is to discover whether the ontology is missing a necessary semantic category.

---

# 2. Critical Rule

Do NOT assume any candidate is primitive merely because it is:

```text
useful
named
persistent
addressable
queryable
stateful
stored
reified
represented by a row
represented by a class
used by workflow engines
common in DDD
common in BPMN
called an object
called an entity
called an event
called a task
called an assignment
called an obligation
```

None of these proves ontological irreducibility.

The decisive criterion remains:

> **Can the complete semantics of the candidate be reduced to the existing ontology without semantic residue?**

If yes:

```text
DERIVED CONCEPT
```

If no:

```text
SEMANTICALLY IRREDUCIBLE
```

Only after irreducibility is demonstrated may primitive status be considered.

---

# 3. Candidate Discovery

Test the following candidate semantic roles:

```text
Attempt
Obligation
Assignment
Event
State
Decision
Instruction
Capability
Resource
Policy
Constraint
Evidence
Observation
Plan
Goal
Trigger
Transition
```

IMPORTANT:

This is NOT a claim that these concepts exist as primitives.

They are adversarial test candidates.

For each candidate ask:

> What semantic work does this concept perform that the existing seven primitives cannot perform?

If the answer is:

```text
none
```

eliminate it.

---

# 4. Test 24A — Candidate Definition Test

For each candidate C:

Attempt:

```text
C = definition over existing primitives + relations + state
```

Construct the strongest possible reduction.

Example:

```text
Assignment
=
relation between Agent and
execution-scoped Workflow Node realization
```

or:

```text
Obligation
=
Workflow/Node constraint + Agent assignment + deadline + Evaluation condition
```

Do not accept vague definitions.

Ask:

1. What is C?
2. What semantic information does C contain?
3. Can every component be represented using existing primitives?
4. Is there semantic residue?

Classify:

```text
FULLY REDUCIBLE
PARTIALLY REDUCIBLE
IRREDUCIBLE
```

---

# 5. Test 24B — Predicate Expansion

For every candidate identify its strongest predicates.

Example:

### Assignment

```text
assigned_to(A,C)
assignment_deadline(C,T)
assignment_status(C,S)
```

### Obligation

```text
owed_by(O,A)
requires(O,R)
due_at(O,T)
fulfilled_by(O,E)
```

### Attempt

```text
attempt_number(X,N)
attempt_of(X,Y)
started_at(X,T)
ended_at(X,T)
produced(X,A)
```

### Event

```text
occurred_at(E,T)
caused(E,X)
triggered_by(E,Y)
```

### Decision

```text
decided_by(D,A)
decision_value(D,V)
decided_at(D,T)
```

For each predicate ask:

> Can the predicate be rewritten entirely in terms of the seven primitives, Workflow Node, relations, state, and derived tuple referents?

If yes:

```text
REDUCIBLE
```

If no:

```text
RESIDUE IDENTIFIED
```

---

# 6. Test 24C — Bearer Test

For each candidate ask:

> What is the bearer of the candidate's predicates?

Examples:

```text
Attempt → what bears attempt_number?
Obligation → what bears due_at?
Decision → what bears decision_value?
Event → what bears occurred_at?
Capability → what bears can_perform?
Policy → what bears policy_constraints?
```

Then ask:

> Can that bearer be reduced to an existing primitive or derived referent?

Do not confuse:

```text
having predicates
```

with:

```text
being primitive
```

---

# 7. Test 24D — Semantic Residue Test

For every candidate construct:

| Candidate   | Claimed semantics | Existing representation | Residue? |
| ----------- | ----------------- | ----------------------- | -------- |
| Attempt     |                   |                         |          |
| Obligation  |                   |                         |          |
| Assignment  |                   |                         |          |
| Event       |                   |                         |          |
| State       |                   |                         |          |
| Decision    |                   |                         |          |
| Instruction |                   |                         |          |
| Capability  |                   |                         |          |
| Resource    |                   |                         |          |
| Policy      |                   |                         |          |
| Constraint  |                   |                         |          |
| Evidence    |                   |                         |          |
| Observation |                   |                         |          |
| Plan        |                   |                         |          |
| Goal        |                   |                         |          |
| Trigger     |                   |                         |          |
| Transition  |                   |                         |          |

The objective is to discover actual semantic residue.

Do not invent residue.

---

# 8. Test 24E — Elimination Test

For each candidate C:

Delete C from the ontology.

Then ask:

> Can every proposition previously expressed using C still be expressed using the seven primitives plus Workflow Node, relations, state, and derived referents?

If yes:

```text
C ELIMINABLE
```

If no:

```text
C NON-ELIMINABLE
```

For every non-eliminable candidate identify the exact proposition that fails.

---

# 9. Test 24F — Quantification Test

Ask whether each candidate requires its own quantifier domain.

Examples:

```text
Every Attempt eventually terminates.

There exists an Obligation that is overdue.

Every Decision has a decision-maker.

No Event occurred before T.

Every Capability possessed by Agent A...
```

Try to rewrite these as quantification over:

```text
Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
relations
state
derived referents
```

If possible:

```text
QUANTIFICATION REDUCIBLE
```

If impossible:

```text
QUANTIFICATION RESIDUE
```

Remember:

> Quantification over a derived referent does not establish a primitive.

---

# 10. Test 24G — Relation Reification Test

For every candidate compare:

```text
R(C,X)
```

with:

```text
R(existing arguments...,X)
```

Examples:

```text
assigned_to(Assignment,A)
```

vs.

```text
assigned_to(E,B,K,A)
```

```text
produced_by(Attempt,A)
```

vs.

```text
produced_by(E,B,K,AttemptKey,A)
```

```text
decision_by(Decision,A)
```

vs.

```text
decision_by(E,B,K,A)
```

Ask:

> Does the candidate add semantic information or merely shorten a relation?

Do not accept cleaner notation as evidence.

---

# 11. Test 24H — Temporal Irreducibility Test

This is especially important.

Test:

```text
Event
Attempt
Transition
State
```

Ask whether temporal semantics can be represented as:

```text
Execution
+
Workflow Node
+
derived referent
+
timestamps
+
state transitions
+
relations
```

Test propositions such as:

```text
B started before C.

B completed after A.

B transitioned from RUNNING to FAILED.

B was retried after FAILURE.

A cancellation occurred before completion.

```

For each ask:

> Is the temporal fact itself a new semantic category, or is it a relation/state over existing referents?

Do not assume:

```text
time-related
therefore Event
```

---

# 12. Test 24I — Deontic Irreducibility Test

Focus on:

```text
Obligation
Permission
Prohibition
Requirement
```

Example:

```text
Agent A must approve request R before T.
```

Try to represent this using:

```text
Agent
Workflow
Workflow Node
Execution
Context
Evaluation
relations
constraints/state
```

Ask:

> Is “must” merely a constraint/policy relation, or does it introduce a fundamentally new semantic category?

Do not smuggle:

```text
Obligation
```

into:

```text
Occurrence
```

Occurrence has already been shown reducible.

---

# 13. Test 24J — Capability Test

Consider:

```text
Agent A can perform Skill S under Context C.
```

Ask:

> Is Capability distinct from Skill?

Try:

```text
has_skill(A,S)
applicable_in(S,C)
```

or equivalent existing relations.

Then test:

```text
A can perform S now.
A cannot perform S under C.
A acquired S after Evaluation E.
```

Determine whether Capability introduces irreducible semantics or merely a relation among existing concepts.

---

# 14. Test 24K — Resource Test

Consider:

```text
Execution E consumed Resource R.
Agent A owns Resource R.
Workflow W requires Resource R.
```

Ask:

> Does Resource constitute an irreducible category?

Or can resources be represented as:

```text
Artifact
Context
Agent
external referent
```

Be precise.

Do not automatically classify physical or external things as Artifact.

If Resource cannot be reduced to any existing primitive without semantic loss, identify exactly why.

---

# 15. Test 24L — Evidence / Observation Test

Consider:

```text
Observation O says metric M = 0.72.
Evidence E supports Evaluation EV1.
```

Ask:

> Is Observation/Evidence a new semantic category or can it be represented through Artifact, Context, Evaluation, and relations?

Test:

```text
source
content
measurement
confidence
timestamp
supports
contradicts
```

Identify any actual semantic residue.

---

# 16. Test 24M — Instruction / Policy / Constraint Test

Distinguish:

```text
Instruction
Policy
Constraint
Requirement
```

Do not collapse them.

Test whether each can be reduced to:

```text
Context
Workflow
Skill
Evaluation
relations
state
```

Ask:

> Does any one of these introduce normative semantics that cannot be represented by existing concepts?

If yes, identify the exact residue.

---

# 17. Test 24N — Cross-Domain Completeness

Apply the seven-primitive ontology to:

```text
CI/CD
Research workflow
Customer support
Human approval
Software development
AI agent orchestration
```

For each domain:

1. Identify the domain's apparent “missing” concepts.
2. Attempt reduction.
3. Identify actual residue.
4. Do NOT add a primitive merely because the domain vocabulary contains a noun.

Create:

| Domain    | Candidate pressure | Reducible? | Residue | Confidence |
| --------- | ------------------ | ---------- | ------- | ---------- |
| CI/CD     |                    |            |         |            |
| Research  |                    |            |         |            |
| Support   |                    |            |         |            |
| Approval  |                    |            |         |            |
| Software  |                    |            |         |            |
| AI agents |                    |            |         |            |

---

# 18. Test 24O — Minimal Counterexample Test

Construct the strongest possible counterexample against the seven primitives.

Do NOT construct a weak example.

Ask:

> What is the smallest scenario in which the seven primitives genuinely fail to express an important truth condition?

Try:

```text
Agent A must do X before T.

Agent A is capable of X but not under Context C.

Execution E was attempted twice.

A policy prohibits action X.

An external event triggered Execution E.

Resource R was reserved exclusively for E.

Decision D commits the workflow to branch B.
```

For each determine whether the problem is:

```text
existing primitive
derived concept
new relation
new state
new semantic category
```

Only if a genuine semantic category survives elimination should it proceed.

---

# 19. Test 24P — Primitive Necessity Gate

For every surviving candidate C require ALL:

1. C is semantically irreducible.
2. C is domain-independent.
3. C is non-redundant with the seven primitives.
4. C is not merely a relation.
5. C is not merely state.
6. C is not merely a tuple/derived referent.
7. Removing C causes semantic loss.
8. No existing primitive can absorb its semantics.
9. The residue is stable across multiple domains.

If any condition fails:

```text
DO NOT ADD PRIMITIVE
```

---

# 20. Test 24Q — Final Completeness Gate

Choose exactly one:

```text
COMPLETE
INCOMPLETE — ONE MISSING SEMANTIC CATEGORY
INCOMPLETE — MULTIPLE MISSING SEMANTIC CATEGORIES
UNRESOLVED
```

Definitions:

### COMPLETE

No candidate survives elimination.

### INCOMPLETE — ONE MISSING SEMANTIC CATEGORY

Exactly one candidate survives.

### INCOMPLETE — MULTIPLE MISSING SEMANTIC CATEGORIES

More than one survives.

### UNRESOLVED

The tests cannot distinguish the alternatives.

---

# 21. Mandatory Anti-Circularity Audit

Explicitly reject arguments such as:

```text
"It has a noun, therefore primitive."

"It is commonly modeled as an entity, therefore primitive."

"It has a lifecycle, therefore primitive."

"It has a database row, therefore primitive."

"It has an ID, therefore primitive."

"It is persistent, therefore primitive."

"It is useful, therefore primitive."

"It appears in workflow engines, therefore primitive."

"It is needed by DDD, therefore primitive."

"It is difficult to represent without a class, therefore primitive."

"It feels conceptually distinct, therefore primitive."

"It has temporal behavior, therefore Event."

"It has a deadline, therefore Obligation."

"It has a value, therefore Artifact."

"It has rules, therefore Policy."

"It can perform something, therefore Capability."

"It is external, therefore Resource."

```

For every invalid argument provide:

```text
WHY INVALID
VALID REPLACEMENT
```

---

# 22. Evidence Classification

Every major conclusion MUST be labeled:

```text
SOURCE-DERIVED
ONTOLOGICAL ARGUMENT
ARCHITECTURAL INFERENCE
PROPOSAL
```

The uploaded sources may inform contextual distinctions, but they are not ontological proof.

In particular:

* The Vibe Coding guide distinguishes PRD, AGENTS, DESIGN_SYSTEM, and ARCHITECTURE as focused project-context documents. This is SOURCE-DERIVED. 
* The Agency material explicitly describes its “employees” as instruction-defined specializations rather than autonomous employees. This is SOURCE-DERIVED. 
* The Claude Design guide describes a Plan → Build → Review process and contextual inputs. This is SOURCE-DERIVED. 

Do NOT use these facts as proof that any ontology category is primitive.

---

# 23. Final Output

Return exactly these sections.

## 1. Executive Verdict

Choose exactly:

```text
COMPLETE
INCOMPLETE — ONE MISSING SEMANTIC CATEGORY
INCOMPLETE — MULTIPLE MISSING SEMANTIC CATEGORIES
UNRESOLVED
```

Explain the strongest reason in ≤5 sentences.

---

## 2. Candidate Audit

For every candidate:

```text
Candidate
Definition
Strongest Predicate
Reduction
Semantic Residue
Eliminable?
Confidence
Evidence Classification
Verdict
```

---

## 3. Semantic Residue Matrix

Complete:

| Candidate   | Semantic residue | Can existing primitives express it? | Eliminable? | Status |
| ----------- | ---------------- | ----------------------------------- | ----------- | ------ |
| Attempt     |                  |                                     |             |        |
| Obligation  |                  |                                     |             |        |
| Assignment  |                  |                                     |             |        |
| Event       |                  |                                     |             |        |
| State       |                  |                                     |             |        |
| Decision    |                  |                                     |             |        |
| Instruction |                  |                                     |             |        |
| Capability  |                  |                                     |             |        |
| Resource    |                  |                                     |             |        |
| Policy      |                  |                                     |             |        |
| Constraint  |                  |                                     |             |        |
| Evidence    |                  |                                     |             |        |
| Observation |                  |                                     |             |        |
| Plan        |                  |                                     |             |        |
| Goal        |                  |                                     |             |        |
| Trigger     |                  |                                     |             |        |
| Transition  |                  |                                     |             |        |

---

## 4. Strongest Counterexample

Present the single strongest scenario that appears to challenge the seven-primitive ontology.

Then reduce it step-by-step.

Conclude:

```text
SURVIVES
```

or:

```text
ELIMINATED
```

---

## 5. Surviving Semantic Categories

If none:

```text
NO NEW SEMANTIC CATEGORY SURVIVED
```

If one or more survive:

Identify them precisely.

Do NOT call them primitives yet.

---

## 6. Primitive #8 Decision

Choose exactly:

```text
NOT JUSTIFIED
JUSTIFIED FOR FURTHER TESTING
JUSTIFIED
```

Remember:

Irreducibility is necessary but not automatically sufficient.

---

## 7. Ontology Status

Choose exactly:

```text
FREEZE 7-PRIMITIVE BASELINE
OPEN ONE NEW PRIMITIVE CANDIDATE
OPEN MULTIPLE PRIMITIVE CANDIDATES
RUN ONE FINAL SEMANTIC TEST
```

If opening a candidate, name it.

---

# Final Constraint

This is still a pure ontology test.

Do NOT:

* implement anything
* create schemas
* create classes
* design APIs
* design databases
* use DDD as proof
* use BPMN as proof
* use workflow-engine terminology as proof
* use persistence as proof
* use addressability as proof
* use UI terminology as proof
* use database representation as proof
* use software architecture as ontological proof

The decisive question is:

> **After Occurrence has been eliminated, is there any other semantic category whose complete meaning cannot be reduced to the existing seven primitives plus Workflow Node, relations, state, and derived referents?**

Be hostile.
Try to break the seven-primitive ontology.
Do not protect it.
But do not add primitives merely because a concept has a name.

---

## Test 25

# Agent Systems Lab — Test 25: Normative Semantics / Resource Boundary Test

You are a hostile ontology architect.

Test 24 concluded:

UNRESOLVED

The 7-primitive ontology survived the candidate sweep.

Current ontology:

Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution

Plus:

Workflow Node
relations
state
derived referents

Test 23 already established:

Occurrence = FULLY REDUCIBLE

Do NOT reopen Occurrence.

Test 24 also established that:

Attempt
Assignment
Event
State
Decision
Instruction
Capability
Constraint
Evidence
Observation
Plan
Goal
Trigger
Transition

do not currently justify primitive status.

Two pressure zones remain:

1. NORMATIVE SEMANTICS
   Obligation / Policy / Permission / Prohibition / Requirement

2. RESOURCE BOUNDARY
   Whether arbitrary resources can always be reduced to existing primitives.

The purpose of Test 25 is NOT to brainstorm primitives.

The purpose is to determine whether either pressure zone contains genuine semantic residue.

Do not protect the 7-primitive ontology.

Do not add a primitive merely because a concept is useful, named, persistent, addressable, stateful, stored, reified, or common in software architecture.

The decisive question remains:

> Can the complete semantics of the proposition be reduced to the existing seven primitives plus Workflow Node, relations, state, and derived referents?

If yes:

FULLY REDUCIBLE

If no:

SEMANTIC RESIDUE

But:

SEMANTIC RESIDUE does NOT automatically mean NEW PRIMITIVE.

You must separately determine whether the residue is:

- a relation
- a property
- state
- temporal structure
- a derived referent
- a semantic operator
- or a genuinely new bearer/category

Only a genuinely irreducible semantic bearer/category can justify a new primitive.

---

# 1. Normative Semantics Test

Do NOT begin with nouns.

Begin with propositions.

Test each proposition literally.

## Proposition N1

Agent A must perform action X before T.

Attempt reduction using only:

Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
relations
state
derived referents

Construct the strongest possible representation.

Then ask:

Can the ontology distinguish:

A performed X before T

from:

A was required to perform X before T

without introducing a new semantic category?

Do not answer by merely inventing:

requires(A,X,T)

That only renames the problem.

Explain what gives `requires` its meaning.

---

## Proposition N2

Agent A may perform action X.

Distinguish:

A can perform X

from:

A is permitted to perform X

These are NOT automatically the same.

Test whether:

Capability

and

Permission

can be semantically separated using existing primitives and relations.

Identify exact residue if any.

---

## Proposition N3

Agent A must not perform X.

Test:

prohibition(A,X)

Can prohibition be represented entirely as:

Context
+
constraint
+
relation
+
state

?

Do not assume that because a rule can be stored in Context, its semantics have been reduced.

---

## Proposition N4

Agent A failed to perform X before T.

Compare:

1. X was not performed before T.
2. A was obligated to perform X before T.
3. A violated that obligation.

Determine whether propositions 1, 2, and 3 are semantically distinguishable.

If yes, identify where the additional semantics live.

If no, prove the collapse.

---

## Proposition N5

Agent A fulfilled an obligation without producing an Artifact.

This is important.

Determine whether obligation fulfillment requires:

Artifact
Execution
Workflow Node
Evaluation

or whether fulfillment can exist purely as a normative relation/state.

If fulfillment can exist without any execution or artifact, test whether the current ontology can represent it.

---

## Proposition N6

An obligation exists before any Execution starts.

This attacks the possibility that all normative semantics can be hidden inside Execution.

Can:

A must perform X before T

exist when:

Execution = none?

If yes, do not smuggle it into Execution.

Find its actual bearer.

---

## Proposition N7

A policy prohibits an action across every Execution of Workflow W.

Test whether Policy is:

1. Context
2. relation
3. constraint
4. state
5. derived referent
6. new semantic category

Do not classify it merely because it is called a Policy.

---

# 2. Deontic Separation Test

Explicitly distinguish:

```text
Capability
Permission
Obligation
Prohibition
Requirement
Constraint
````

Test these pairs:

```text
Can ≠ May
May ≠ Must
Must ≠ Must-not
Must-not ≠ Cannot
Cannot ≠ Forbidden
```

For each pair ask:

> Can the semantic difference be represented using existing primitives plus relations/state?

If yes, show the representation.

If no, identify the exact residue.

Do NOT collapse normative semantics into capability.

---

# 3. Normative Bearer Test

For every surviving normative proposition ask:

> What is the bearer of the normative predicate?

Examples:

```text
must(A,X,T)
may(A,X)
forbidden(A,X)
required(A,X)
breached(A,X)
fulfilled(A,X)
```

Possible answers:

```text
Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
derived referent
relation
state
new bearer
```

Do not assume the predicate's bearer is a new primitive.

The critical question is:

> Is normative force itself a property/relation over existing bearers, or does it require a new semantic bearer?

---

# 4. Normative Quantification Test

Test:

```text
Every Agent assigned to Workflow W must perform X before T.

No Agent may perform X under Context C.

There exists an overdue requirement.

Every fulfilled requirement has evidence.

Every prohibition applies to all Executions of W.
```

Try to quantify over:

Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
derived referents
relations
state

If all propositions remain expressible:

QUANTIFICATION REDUCIBLE

If not:

identify exact residue.

Remember:

A quantifier over a derived relation does NOT prove a primitive.

---

# 5. Normative Temporal Test

Test:

```text
A must perform X before T.

A became obligated at T1.

A fulfilled the obligation at T2.

The obligation became overdue at T3.

The obligation was waived at T4.

The obligation was violated at T5.
```

Ask:

Can these be represented using:

existing referents
+
timestamps
+
relations
+
state

?

Do not create Event or Obligation merely because time is involved.

The test is about semantic residue, not vocabulary.

---

# 6. Resource Boundary Test

Now attack the second unresolved area.

Do NOT define Resource first.

Use concrete propositions.

## R1

Execution E consumed resource R.

## R2

Workflow W requires resource R.

## R3

Agent A owns resource R.

## R4

Resource R is reserved exclusively for Execution E.

## R5

Resource R becomes unavailable after E consumes it.

## R6

Resource R is shared by two Executions.

## R7

Resource R is an external physical object.

## R8

Resource R is an external service.

## R9

Resource R is a human-controlled facility.

## R10

Resource R is a scarce capability/token/quota.

For every case determine whether R can be represented as:

Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
external referent
derived referent

Do NOT automatically classify every external thing as Artifact.

Instead ask:

> What semantics does R possess that are not captured by the existing category?

---

# 7. Resource Semantic Separation Test

Distinguish:

```text
Artifact
Resource
Context
Capability
External Entity
```

Test:

```text
A document can be both an Artifact and a Resource.

A GPU can be a Resource.

An API quota can be a Resource.

A human operator can be a Resource in some workflow models.

A database connection can be a Resource.

A physical room can be a Resource.
```

Do not classify based on common terminology.

For each determine:

1. What is the thing?
2. What predicates does it bear?
3. Which existing primitive could bear those predicates?
4. What semantic residue remains?
5. Is the residue intrinsic to the thing or merely relational?

Critical distinction:

> Being USED AS a resource is not necessarily BEING a Resource.

Test that distinction explicitly.

---

# 8. Resource Bearer Test

For:

```text
owns(A,R)
consumes(E,R)
reserves(E,R)
requires(W,R)
shares(E1,E2,R)
```

ask:

> Does R require a new ontological category?

Compare:

```text
Artifact R
+
consumed_by(E,R)
```

with:

```text
Resource R
+
consumed_by(E,R)
```

What semantic information is lost?

If nothing is lost:

RESOURCE = ROLE / RELATIONAL CLASSIFICATION

If something is lost:

identify exactly what.

Do not accept:

"Resource feels different."

---

# 9. Role vs Category Test

This test is mandatory.

A single thing may play multiple roles.

For example:

```text
Artifact A
can be used as Resource R
```

or:

```text
Agent A
can act as Resource R
```

or:

```text
Context C
can function as Resource R
```

Ask:

> Is "Resource" intrinsic identity, or a role played by an existing entity in a relation?

Likewise test:

```text
Evidence
Observation
Capability
Assignment
Requirement
```

Do not confuse role with primitive category.

---

# 10. Minimal Counterexamples

Construct the strongest counterexample for:

### Normative semantics

```text
A must do X before T,
but no Execution exists.
```

### Resource semantics

```text
R is consumed exclusively by E,
but R is neither obviously an Artifact nor a Context.
```

For each:

1. State the proposition.
2. Attempt complete reduction.
3. Identify exact residue.
4. Determine bearer.
5. Determine whether residue is relation/state/role/category.
6. Attempt elimination.
7. Decide whether the residue survives.

---

# 11. Anti-Smuggling Test

Reject these arguments:

```text
"It has the word must, therefore Obligation."

"It has a prohibition, therefore Policy."

"It can be consumed, therefore Resource."

"It is external, therefore Resource."

"It has a deadline, therefore Obligation."

"It has a lifecycle, therefore primitive."

"It is a normative statement, therefore new entity."

"It cannot be represented by one table, therefore primitive."

"It needs a special relation, therefore primitive."

"It needs a special predicate, therefore primitive."

"It is difficult to encode, therefore primitive."

"It has a role name, therefore category."

"It is a role in one workflow, therefore primitive."
```

For every invalid argument state:

WHY INVALID

and:

VALID REPLACEMENT

---

# 12. Cross-Domain Validation

Apply the surviving normative/resource semantics to:

```text
CI/CD
Research
Customer Support
Human Approval
Software Development
AI Agent Orchestration
```

For each domain test:

```text
normative rule
resource usage
```

Ask whether the same semantic residue appears across domains.

If residue appears only in one domain:

DOMAIN-SPECIFIC

If residue appears consistently:

DOMAIN-INDEPENDENT

Do not use domain frequency as proof by itself.

---

# 13. Primitive Necessity Gate

A new primitive may survive ONLY if ALL are true:

1. Genuine semantic residue exists.
2. The residue cannot be represented as a relation.
3. The residue cannot be represented as state.
4. The residue cannot be represented as a role.
5. The residue cannot be represented as a derived referent.
6. The residue cannot be absorbed by an existing primitive.
7. Removing the candidate causes semantic loss.
8. The candidate has an identifiable bearer.
9. The category is domain-independent.
10. The category remains necessary under alternative formulations.

If ANY condition fails:

DO NOT ADD PRIMITIVE.

---

# 14. Final Decision

Choose exactly one:

COMPLETE

INCOMPLETE — ONE MISSING SEMANTIC CATEGORY

INCOMPLETE — MULTIPLE MISSING SEMANTIC CATEGORIES

UNRESOLVED

Definitions:

COMPLETE:
No semantic residue survives.

INCOMPLETE — ONE:
Exactly one genuine semantic category survives.

INCOMPLETE — MULTIPLE:
More than one genuine semantic category survives.

UNRESOLVED:
The tests cannot distinguish between reduction and genuine residue.

---

# 15. Primitive #8 Decision

Choose exactly one:

NOT JUSTIFIED

JUSTIFIED FOR FURTHER TESTING

JUSTIFIED

Remember:

Irreducibility is necessary but not sufficient.

---

# 16. Ontology Status

Choose exactly one:

FREEZE 7-PRIMITIVE BASELINE

OPEN ONE NEW PRIMITIVE CANDIDATE

OPEN MULTIPLE PRIMITIVE CANDIDATES

RUN ONE FINAL SEMANTIC TEST

If opening a candidate, name it.

---

# 17. Mandatory Final Output

Return exactly these sections.

## 1. Executive Verdict

Maximum 5 sentences.

## 2. Normative Semantics Audit

| Proposition | Reduction | Residue | Bearer | Eliminable? | Verdict |
| ----------- | --------- | ------- | ------ | ----------- | ------- |

## 3. Resource Audit

| Proposition | Reduction | Residue | Bearer | Role or Category? | Eliminable? | Verdict |
| ----------- | --------- | ------- | ------ | ----------------- | ----------- | ------- |

## 4. Deontic Separation Matrix

| Concept     | Distinct from | Reduction | Residue | Status |
| ----------- | ------------- | --------- | ------- | ------ |
| Capability  | Permission    |           |         |        |
| Permission  | Obligation    |           |         |        |
| Obligation  | Prohibition   |           |         |        |
| Prohibition | Inability     |           |         |        |
| Requirement | Constraint    |           |         |        |

## 5. Strongest Normative Counterexample

Reduce it step-by-step.

End with:

SURVIVES

or

ELIMINATED

## 6. Strongest Resource Counterexample

Reduce it step-by-step.

End with:

SURVIVES

or

ELIMINATED

## 7. Semantic Residue

List ONLY genuine unresolved residue.

If none:

NO SEMANTIC RESIDUE

## 8. Primitive #8 Decision

Choose:

NOT JUSTIFIED
JUSTIFIED FOR FURTHER TESTING
JUSTIFIED

Explain why.

## 9. Ontology Status

Choose:

FREEZE 7-PRIMITIVE BASELINE
OPEN ONE NEW PRIMITIVE CANDIDATE
OPEN MULTIPLE PRIMITIVE CANDIDATES
RUN ONE FINAL SEMANTIC TEST

## 10. Evidence Classification

For every major conclusion label:

SOURCE-DERIVED
ONTOLOGICAL ARGUMENT
ARCHITECTURAL INFERENCE
PROPOSAL

Important:

Uploaded sources may inform contextual distinctions but MUST NOT be treated as ontological proof.

Do not cite DDD, BPMN, workflow engines, databases, software architecture, UI terminology, or implementation patterns as ontological proof.

The only decisive criterion is semantic reducibility.

---

# Final Constraint

Do not brainstorm.

Do not add primitives because they are convenient.

Do not reopen eliminated candidates unless a normative/resource proposition directly depends on them.

The only question is:

> Can normative force and resource semantics be completely reduced to the existing seven primitives plus Workflow Node, relations, state, roles, and derived referents?

Be hostile.

Try to break the ontology.

If it survives, freeze it.

If it breaks, identify the exact semantic category that broke it.

Do not guess.

````

---

## Test 26

# Agent Systems Lab — Test 26: Arbitrary Resource / Resource Boundary Test

You are a hostile ontology architect.

Test 25 concluded:

**UNRESOLVED, but no new primitive was justified.**

The current ontology is:

* Agent
* Skill
* Context
* Artifact
* Evaluation
* Workflow
* Execution

Plus:

* Workflow Node
* relations
* state
* temporal structure
* derived referents
* semantic operators

Test 23 established:

**Occurrence = FULLY REDUCIBLE**

Test 24 established that:

Attempt, Assignment, Event, State, Decision, Instruction, Capability, Constraint, Evidence, Observation, Plan, Goal, Trigger, Transition

do not currently justify primitive status.

Test 25 established:

* Capability ≠ Permission
* Permission ≠ Obligation
* Obligation ≠ Prohibition
* Nonperformance ≠ Obligation ≠ Violation
* Obligation can exist before Execution
* Fulfillment can exist without producing an Artifact
* Normative semantics are genuine semantic residue
* But no irreducible normative bearer has been demonstrated

Therefore:

**Do NOT reopen normative semantics.**

The only remaining pressure zone is:

# RESOURCE BOUNDARY

The purpose of Test 26 is NOT to decide whether “Resource” is useful.

The purpose is to determine whether arbitrary resource semantics can be completely reduced to:

Agent
Skill
Context
Artifact
Evaluation
Workflow
Execution
Workflow Node
relations
state
temporal structure
derived referents
semantic operators

The decisive question remains:

> Can the complete semantics of an arbitrary resource proposition be represented without introducing a new irreducible bearer/category?

If yes:

**FULLY REDUCIBLE**

If no:

**SEMANTIC RESIDUE**

But:

**SEMANTIC RESIDUE does NOT automatically justify a new primitive.**

The residue must be classified as:

* relation
* property
* state
* temporal structure
* derived referent
* semantic operator
* or genuinely new bearer/category

Only the final category can justify Primitive #8.

---

# 1. Start With Propositions, Not Nouns

Do NOT begin with:

> “What is a Resource?”

Begin with concrete propositions.

For each proposition:

1. Construct the strongest possible representation using the existing ontology.
2. Do not introduce `Resource` as a hidden parameter.
3. Do not invent predicates that merely rename the missing concept.
4. Identify exactly what semantic content is not captured.
5. Classify the residue.
6. Determine whether the residue requires a new bearer.

---

# 2. Resource Case R1 — Money

Proposition:

> Workflow W has a budget of $10,000.

Test whether this can be represented using:

* Artifact
* Context
* Workflow
* state
* relations

Now test:

> Workflow W has spent $3,000 of its $10,000 budget.

Then:

> Workflow W has $7,000 remaining.

Determine whether:

* money is an Artifact,
* money is Context,
* budget is merely state,
* budget is a relation,
* or some irreducible bearer is required.

Do not assume that “money” is a Resource primitive merely because software systems call it a resource.

---

# 3. R2 — CPU Capacity

Proposition:

> Execution E is allocated 4 CPU cores for 30 minutes.

Test whether the semantics can be represented without a Resource bearer.

The representation must preserve:

* identity of the capacity
* quantity
* allocation
* duration
* exclusivity if present
* consumption if present

Then test:

> Another Execution cannot use those 4 cores during that interval.

Can this be expressed using:

state + relation + temporal structure

without losing semantics?

---

# 4. R3 — RAM

Proposition:

> Execution E requires 8 GB RAM.

Compare:

1. E requires 8 GB RAM.
2. E has access to 8 GB RAM.
3. E consumed 6 GB RAM.
4. Only 2 GB RAM remains available.

These are not automatically equivalent.

Determine whether the ontology can represent:

* capacity
* requirement
* allocation
* availability
* consumption

without introducing a new bearer.

---

# 5. R4 — Database Connections

Proposition:

> Workflow W has access to a database connection pool containing 20 concurrent connections.

Then:

> Execution E consumes 3 connections.

Then:

> Only 17 connections remain available.

Then:

> Execution F is denied because all remaining connections are reserved.

Test whether the ontology preserves:

* pool identity
* capacity
* allocation
* consumption
* availability
* exclusivity
* denial

without a Resource primitive.

Do not collapse all of these into “state” unless you explicitly demonstrate the full truth conditions.

---

# 6. R5 — Physical Object

Proposition:

> Execution E requires forklift F.

Then:

> Forklift F is currently assigned to E.

Then:

> Execution E uses F from 10:00 to 12:00.

Then:

> Execution G cannot use F during that interval.

This is intentionally adversarial.

Ask:

Is forklift F:

* Artifact?
* Context?
* Agent?
* Workflow?
* Execution?
* derived referent?

If none works, identify exactly why.

Do NOT answer:

> “Forklift is a Resource.”

That merely renames the unresolved category.

---

# 7. R6 — Human Time

Proposition:

> Agent A has 20 hours available this week for Workflow W.

Then:

> Workflow W consumes 5 hours of A's time.

Then:

> A has 15 hours remaining.

Test whether:

* Agent + state
* Agent + Context
* Workflow + relation
* temporal structure

can represent this completely.

Be especially hostile to the assumption that every allocatable quantity must become a Resource entity.

---

# 8. R7 — API Quota

Proposition:

> Agent A has a quota of 10,000 API calls per day.

Then:

> A has consumed 7,500 calls.

Then:

> 2,500 calls remain.

Then:

> A is denied because the quota has been exhausted.

Test:

* identity of quota
* limit
* time window
* consumption
* remaining capacity
* enforcement

Can this be represented as:

Context + state + temporal structure + relation

or is something irreducible missing?

---

# 9. R8 — Inventory

Proposition:

> Warehouse W contains 500 units of product P.

Then:

> Execution E reserves 100 units.

Then:

> Execution F attempts to reserve 450 units.

Then:

> F is denied because only 400 units remain unreserved.

Test whether inventory requires a new bearer.

Do not confuse:

```text
Product
Quantity
Inventory state
Reservation
Availability
```

with one semantic category.

Determine the minimal representation.

---

# 10. R9 — Energy

Proposition:

> Device D has 50 kWh available.

Then:

> Execution E consumes 10 kWh.

Then:

> 40 kWh remain.

Then:

> Execution F cannot start because minimum required energy is 45 kWh.

Test whether energy itself introduces a new bearer or whether:

quantity + state + relation + context

is sufficient.

---

# 11. R10 — License

Proposition:

> Workflow W requires a software license L.

Then:

> License L permits 5 concurrent executions.

Then:

> Three executions currently occupy the license.

Then:

> A sixth execution is denied.

This case is intentionally difficult because “license” contains:

* identity
* authorization
* capacity
* temporal validity
* exclusivity
* normative semantics
* allocation

Do NOT classify the whole thing as Resource.

Decompose it.

Determine which semantics belong to:

* Context
* Artifact
* normative operator
* state
* relation
* derived referent

and whether any residue remains.

---

# 12. R11 — Network Bandwidth

Proposition:

> Execution E is allocated 100 Mbps bandwidth.

Then:

> Execution F can use only the remaining bandwidth.

Then:

> E releases its allocation.

Test whether bandwidth is:

* a quantity/state,
* a Context property,
* an Artifact,
* or a bearer.

Preserve:

* capacity
* allocation
* availability
* release
* temporal scope

---

# 13. R12 — Generic Adversarial Resource

Construct the strongest possible resource example yourself.

It must have:

* persistent identity
* measurable capacity
* availability
* ownership
* allocation
* exclusivity
* consumption
* temporal behavior
* causal consequences

Do not choose an example that is trivially an Artifact.

Then attempt complete reduction.

This is the most important case.

---

# 14. Anti-Smuggling Rules

You are NOT allowed to solve the problem by silently introducing:

```text
Resource R
Capacity(R)
Available(R)
Owns(A,R)
Allocates(E,R)
Consumes(E,R)
```

because this simply assumes the existence of the missing bearer.

Likewise, do not write:

```text
requires(E,R)
```

and declare the problem solved.

Ask:

> What is R ontologically?

If R is merely a derived referent, explain exactly how it is derived.

If R is a Context, explain why its identity and persistence are fully preserved.

If R is an Artifact, explain why its capacity, availability, and causal behavior do not introduce additional semantics.

If R is neither, identify the exact irreducible bearer semantics.

---

# 15. The Artifact Challenge

Test the strongest argument for:

> Resource = Artifact.

Ask whether an Artifact can have:

* capacity
* availability
* allocation
* reservation
* consumption
* replenishment
* exclusivity
* causal effect on execution

If yes, demonstrate it.

If no, identify precisely where Artifact semantics fail.

Do not reject Artifact merely because the word “resource” sounds different.

---

# 16. The Context Challenge

Test the strongest argument for:

> Resource = Context.

Ask whether Context can fully represent:

> “This exact physical forklift is allocated to Execution E from 10:00–12:00 and cannot simultaneously serve another Execution.”

If yes, provide the reduction.

If no, identify the missing bearer semantics.

---

# 17. The Agent Challenge

Test human and organizational resources:

> Agent A has 20 available hours.

Determine whether this is simply:

```text
Agent
+
state
+
temporal structure
```

If yes, do not create Resource.

If no, explain why.

---

# 18. The Derived Referent Challenge

Attempt the strongest primitive-free solution:

> Resource is never a primitive. It is always a derived referent constructed from an existing bearer plus a capacity/property/state relation.

For example:

```text
Agent A
→ available-time referent

Context C
→ available-capacity referent

Artifact X
→ consumable-capacity referent

Workflow W
→ allocated-budget referent
```

Test whether this strategy works universally.

If it fails, provide the smallest counterexample.

---

# 19. Resource Identity Test

A critical distinction:

```text
the resource itself
vs
the resource state
```

For example:

> Forklift F remains the same forklift while its state changes from:

available
→ reserved
→ in-use
→ unavailable.

Determine whether identity can be inherited from an existing primitive bearer.

If yes, Resource does not need primitive identity.

If no, explain why.

---

# 20. Resource Capacity Test

Separate:

```text
bearer
capacity
availability
allocation
consumption
```

Do not treat them as one object.

For each case determine whether capacity is:

* property
* state
* relation
* derived referent

rather than a primitive.

---

# 21. Resource Causality Test

This is the strongest attack.

Consider:

> Removing resource R makes Execution E impossible.

Ask:

Can the existing ontology represent the causal dependency without treating R as an independent bearer?

If not, identify the missing semantics.

This test matters because a mere numeric value does not necessarily behave like a resource.

---

# 22. Decision Rule

For every case classify the result as exactly one of:

### FULLY REDUCIBLE

All semantics preserved.

### SEMANTIC RESIDUE — NON-BEARER

Some semantics remain, but they are fully classifiable as:

* relation
* property
* state
* temporal structure
* derived referent
* semantic operator

### SEMANTIC RESIDUE — BEARER

Some semantics cannot be represented without introducing an independent bearer/category.

Only this result can justify Primitive #8.

---

# 23. Required Output Format

Produce the final answer in exactly this structure:

## 1. Executive Verdict

Choose:

* FULLY REDUCIBLE
* SEMANTIC RESIDUE — NON-BEARER
* SEMANTIC RESIDUE — BEARER
* UNRESOLVED

## 2. Reduction Matrix

| Case | Strongest existing reduction | Preserved semantics | Lost semantics | Residue type | Primitive required? |
| ---- | ---------------------------- | ------------------- | -------------- | ------------ | ------------------- |

Include R1–R12.

## 3. Hardest Counterexample

Identify the single case that puts maximum pressure on the seven primitives.

Explain why it is harder than the others.

## 4. Artifact vs Context vs Derived Referent

Explicitly compare the three strongest primitive-free strategies.

## 5. Resource Identity

Determine whether resource identity can always be inherited from:

Agent / Artifact / Context / Workflow / Execution

or whether an independent bearer is required.

## 6. Capacity Semantics

Determine whether:

capacity
availability
allocation
reservation
consumption

are reducible to property/state/relation/temporal structure.

## 7. Causality

Test whether resource-dependent execution can be represented without a Resource bearer.

## 8. Primitive #8 Decision

Choose exactly one:

* NOT JUSTIFIED
* JUSTIFIED
* STILL UNRESOLVED

If JUSTIFIED, specify the minimal semantic category required.

Do NOT name it “Resource” unless the evidence proves that the category is actually resource-general.

## 9. Ontology Update

Give the smallest possible change to the ontology.

If no change is justified, explicitly say:

> No primitive added.

## 10. Anti-Circularity Audit

List every place where the argument could have secretly assumed the conclusion.

Be hostile to your own reduction.

## 11. Final Falsification Question

End with ONE question that, if answered negatively, would falsify the current ontology.

Do not invent additional tests unless the current evidence logically requires them.

---

# Core Principle

Do not ask:

> “Can I model this as a Resource?”

Ask:

> “What semantic bearer, if any, must exist for these propositions to be true, and can that bearer be inherited from the seven existing primitives?”

Do not protect the seven primitives.

If they fail, break them.

If they survive, prove why.

---

## Test 27

# Agent Systems Lab — Test 27: Artifact Boundary / General Bearer Test
You are a hostile ontology architect.
Test 26 produced:
**SEMANTIC RESIDUE — BEARER**
The proposed interpretation was:
> Resource itself is not necessarily primitive.
> Resource may be a derived role over an existing bearer.
> A possible missing primitive is a general `Entity` / `Bearer`.
However, Test 26 contains a critical unresolved assumption:
> A physical or external resource such as a forklift may fail to fit the existing ontology because `Artifact` was implicitly treated as narrower than “any independently identifiable object.”
Therefore:
# DO NOT ADD ENTITY YET.
The next task is to attack the strongest alternative:
> **Artifact may already be the general bearer.**
The purpose of Test 27 is NOT to defend or reject Artifact by intuition.
The purpose is to determine:
> **Can Artifact, without semantic distortion or ad-hoc expansion, serve as the general bearer for every independently identifiable object that may participate in relations, states, capacity, allocation, ownership, temporal behavior, and causal dependencies?**
If yes:
**Test 26's proposed Entity primitive is not justified.**
If no:
determine the exact counterexample and whether the failure is:
* relation
* property
* state
* temporal structure
* derived referent
* semantic operator
* or genuinely missing bearer/category.
Do NOT reopen normative semantics.
Do NOT introduce `Entity` at the beginning.
Do NOT assume Resource.
Do NOT redefine Artifact merely to make it pass.
---
# 1. Start With the Definition Boundary
Do not begin with:
> “A forklift is not an Artifact.”
That would be circular.
Instead ask:
> What semantic commitments are already contained in `Artifact`?
Determine whether Artifact means:
A. produced output
B. informational/digital object
C. persistent identifiable object
D. any independently identifiable object participating in workflows
E. something else
Use only the ontology established by Tests 23–26.
If the previous tests do not specify Artifact's extension, explicitly mark this as an unresolved assumption.
Do not silently choose the broadest interpretation.
---
# 2. Artifact Generality Test
Test whether the following can all legitimately be Artifacts:
### A1 — Forklift
> Forklift F exists independently of Workflow W.
F has:
* persistent identity
* owner
* physical location
* capacity
* availability
* allocation
* exclusive use
* temporal state
* causal effect on Execution
Can F be an Artifact without changing the meaning of Artifact?
---
### A2 — Laptop
> Laptop L is assigned to Agent A for six months.
L can be:
* available
* assigned
* in use
* repaired
* unavailable
Can L be an Artifact?
---
### A3 — Building
> Building B is available for Workflow W from January to June.
B has:
* persistent identity
* location
* ownership
* capacity
* availability
* occupancy
* exclusion
Can B be an Artifact?
---
### A4 — Natural Object
> River R supplies water required by Execution E.
R:
* exists independently of workflows
* has measurable capacity
* can be available/unavailable
* has physical effects
* is not produced by a workflow
Can R be an Artifact?
This is intentionally adversarial.
Do not say:
> “No, because it is natural.”
That is not an ontological argument unless Artifact was explicitly defined as a produced object.
---
### A5 — Location
> Location L is required for Execution E.
L has:
* identity
* spatial persistence
* capacity
* availability
* ownership or control
* temporal constraints
* causal relevance
Can a location be an Artifact?
---
### A6 — Organization
> Organization O provides access to infrastructure required by Workflow W.
O has:
* identity
* ownership/control
* capabilities
* availability
* temporal state
* causal relevance
Can O be an Artifact?
Do not automatically classify it as Agent.
Test the existing definition.
---
### A7 — Service Endpoint
> API endpoint X is available to Execution E.
X has:
* persistent identity
* availability
* capacity/quota
* ownership/control
* temporal validity
* causal consequences
Can X be an Artifact?
---
### A8 — Abstract External Object
Construct your own strongest example that:
* has persistent identity
* exists independently
* is not produced by a workflow
* is not necessarily human
* is not merely a Context
* participates in relations
* has state
* can affect execution
* can become unavailable
Then test whether it can honestly be an Artifact.
---
# 3. Anti-Reclassification Test
For every candidate ask:
> Are we calling this an Artifact because it actually satisfies Artifact semantics, or merely because we need somewhere to put it?
These are NOT equivalent:
```text
X is an Artifact
```
and:
```text
We can represent X by abusing Artifact.
```
If accepting X as Artifact requires changing Artifact's meaning, record that as semantic expansion.
Do not count semantic expansion as successful reduction.
---
# 4. Artifact Identity Test
Test:
> Artifact A remains numerically/identifiably the same object while its state changes.
For example:
```text
Forklift F
available
→ reserved
→ in-use
→ unavailable
→ repaired
→ available
```
Ask:
1. Is F itself the Artifact?
2. Or is the Artifact merely a representation of F?
3. If it is a representation, where is F's actual bearer identity?
4. Does the ontology distinguish bearer from representation?
5. If not, is that distinction actually necessary?
Do not assume that “identity” automatically creates a primitive.
---
# 5. Artifact vs Context
For each hard case compare:
### Strategy A
```text
X = Artifact
state(X,t)
relations(X,...)
```
### Strategy B
```text
X = Context
state(X,t)
relations(X,...)
```
Determine which one preserves:
* identity
* persistence
* ownership
* capacity
* allocation
* exclusivity
* temporal state
* causal participation
Do not let Context become a generic dumping ground.
---
# 6. Artifact vs Derived Referent
Test:
```text
Artifact X
→ capacity(X)
→ availability(X,t)
→ allocation(X,E,t)
→ consumption(E,X)
```
against:
```text
X
→ derived resource-capacity referent
```
Ask:
> Does the derived referent eliminate the need for X as a bearer?
If the answer is no, explain exactly why.
If yes, explain how X itself is represented.
---
# 7. The “Produced” Trap
Attack this distinction:
> Artifact = something produced.
Ask:
* Does the existing ontology actually define Artifact this way?
* If yes, can physical external objects still be Artifacts?
* If no, why were physical objects excluded?
* Would expanding Artifact to all persistent objects destroy a meaningful distinction?
Do not assume “artifact” has its ordinary English meaning.
Use the ontology's semantic definition.
---
# 8. The Representation Trap
Consider:
> Database row representing forklift F.
The row is clearly an Artifact or informational artifact.
But:
```text
Database representation of F
≠
Forklift F
```
Test whether the ontology needs to represent the distinction.
If the system only cares about the representation, perhaps Artifact is sufficient.
If the ontology makes claims about:
* ownership of F
* physical capacity of F
* physical location of F
* F being unavailable
* F causing E to fail
determine whether those predicates apply to the representation or to F itself.
Do not assume that the database representation is the bearer.
---
# 9. Causal Bearer Test
Use:
> Removing X makes Execution E impossible.
Test:
```text
X = Artifact
```
versus:
```text
X = Context
```
versus:
```text
X = derived referent
```
Determine whether the causal relation can preserve the truth:
> X itself is the thing whose absence causes the execution failure.
If replacing X with a representation changes the proposition, record the semantic loss.
---
# 10. Arbitrary Bearer Stress Test
Construct at least 5 additional cases from different ontological families:
1. physical object
2. place
3. organization
4. natural object
5. external digital service
For each ask:
> Can this legitimately be Artifact without changing Artifact's definition?
Do not classify based on intuition.
---
# 11. Minimality Test
Suppose Artifact can cover:
```text
forklift
machine
license
inventory
building
API endpoint
```
Ask:
> Does adding Entity still buy us anything?
If no:
**Primitive #8 NOT JUSTIFIED.**
Suppose Artifact cannot cover some independently existing bearer.
Ask:
> What is the smallest category that covers exactly the missing cases?
Do not immediately call it Entity.
Possible conclusions:
* Artifact must be broadened
* Context must be broadened
* a new general bearer is required
* the ontology's scope must be narrowed
* the distinction is merely linguistic and no primitive is needed
---
# 12. Scope Test
This is critical.
Determine whether the ontology intends to model:
A. only software/workflow objects
B. organizational systems
C. physical-world systems
D. arbitrary real-world entities
E. all of the above
If the ontology's scope is not specified, do not silently choose D.
A primitive may be unnecessary under a restricted ontology and necessary under a universal ontology.
---
# 13. Decision Rule
For each candidate classify:
### FULLY ABSORBABLE INTO ARTIFACT
The object is legitimately an Artifact under the existing semantics.
### ABSORBABLE ONLY BY SEMANTIC EXPANSION
It can be forced into Artifact, but only by changing Artifact's meaning.
### CONTEXT BETTER
Artifact is not the correct bearer; Context preserves semantics.
### DERIVED REFERENT SUFFICIENT
No independent bearer is needed.
### GENUINE BEARER RESIDUE
The object cannot be represented by Artifact, Context, Agent, Workflow, Execution, or derived referents without semantic loss.
Only the last result can justify a new primitive.
---
# 14. Required Output Format
Produce exactly:
## 1. Executive Verdict
Choose exactly one:
* FULLY REDUCIBLE
* SEMANTIC RESIDUE — NON-BEARER
* SEMANTIC RESIDUE — BEARER
* UNRESOLVED
Then state whether Test 26's proposed `Entity` primitive survives.
---
## 2. Artifact Boundary Matrix
| Case | Can legitimately be Artifact? | Why? | Semantic loss? | Alternative | Verdict |
| ---- | ----------------------------- | ---- | -------------- | ----------- | ------- |
Include:
A1–A8.
---
## 3. Hardest Artifact Counterexample
Identify the single strongest case that cannot honestly be treated as Artifact, if one exists.
If none exists, explain why all cases can be absorbed.
---
## 4. Artifact Definition Audit
State the narrowest and broadest plausible meanings of Artifact.
Then determine:
> Which definition is actually supported by the existing ontology?
Do not invent missing definitions.
---
## 5. Representation vs Bearer
Explicitly distinguish:
```text
thing itself
vs
representation of the thing
vs
state of the thing
vs
resource-role of the thing
```
Determine whether the ontology needs all four.
---
## 6. Context Challenge
Determine whether Context can absorb the cases that Artifact cannot.
Do not let Context become a universal container.
---
## 7. Derived Referent Challenge
Determine whether all apparent resources can be derived from:
```text
existing bearer
+
property
+
state
+
relation
+
temporal structure
```
If not, provide the smallest counterexample.
---
## 8. Scope Decision
Determine whether Primitive #8 is required under:
### Restricted scope
Software/workflow systems only.
### Broad scope
Physical + organizational + digital systems.
### Universal scope
Arbitrary independently existing entities.
Give the result for each scope separately.
---
## 9. Primitive #8 Decision
Choose exactly one:
* NOT JUSTIFIED
* JUSTIFIED
* STILL UNRESOLVED
If JUSTIFIED:
Do NOT call it Resource.
Define the smallest possible semantic category.
---
## 10. Ontology Update
Give the smallest possible change.
If no change:
> No primitive added.
If Artifact must be broadened:
state the exact new definition.
If a new bearer is required:
state the minimum category without overgeneralizing.
---
## 11. Anti-Circularity Audit
List every assumption that could have secretly made Artifact succeed or fail.
Be hostile to your own conclusion.
---
## 12. Final Falsification Question
End with exactly ONE question.
It must be strong enough that a “yes” or “no” answer could overturn the current conclusion.
Do not invent Test 28 unless the evidence from Test 27 logically requires it.
# Core Principle
Do not ask:
> “Can I call this an Artifact?”
Ask:
> **“Does this object satisfy the existing semantic commitments of Artifact, independently of whether I need it to fit there?”**
And:
> **“If I broaden Artifact enough to absorb it, have I preserved the original distinction, or have I simply hidden a new primitive inside a redefinition?”**
The goal is not to minimize the number of primitives at any cost.
The goal is to find the **smallest ontology that preserves all truth conditions without semantic smuggling.**
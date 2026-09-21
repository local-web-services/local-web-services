## Context

AWS Step Functions added JSONata as an alternative to JSONPath in ASL (Amazon States Language).
JSONata is a query and transformation language for JSON — more expressive than JSONPath, supporting
string functions, arithmetic, conditionals, and aggregations.

LWS currently only handles JSONPath. Adding JSONata requires:
1. A Python library to evaluate JSONata expressions
2. ASL parser changes to read the new fields
3. Engine dispatch logic to route JSONata-mode states through the new evaluator

## Goals / Non-Goals

Goals:
- Support `"QueryLanguage": "JSONata"` at state machine and per-state level
- Evaluate `{%...%}` expression syntax in `Arguments` and `Output` fields
- Bind `$states.input` and `$states.result` so expressions can reference execution context
- Pass and Task state support as the primary use case

Non-Goals:
- `Assign` field (variable binding for later states) — deferred
- JSONata in `Condition` within Choice states — deferred
- Full JSONata function library parity with AWS — best-effort via the library

## Decisions

**Decision: Use `jsonata-python` library**
See `adrs/adr-001-jsonata-python-library/adr.md`.

**Decision: Resolve effective query language at execution time, not parse time**
The engine checks `state.query_language or definition.query_language` per state execution.
This avoids a two-pass parser and keeps parsing stateless. Cost: one attribute lookup per state.

**Decision: JSONata helpers stay in `_engine_helpers.py`**
Adding 4–5 small helpers (~40 lines) keeps `engine.py` under the 500-line limit and follows the
existing pattern of keeping engine mechanics in helpers.

**Decision: `Arguments` and `Output` are additive; existing fields still parsed**
A state can have both `Parameters` (JSONPath) and `Arguments` (JSONata) in its ASL JSON — only
the field matching the active query language is used. No field removal needed.

## Risks / Trade-offs

- `jsonata-python` is a third-party port; full AWS JSONata parity not guaranteed → tested only
  for the scenarios in the feature file; gaps become known when user runs real state machines.
- Adding `jsonata-python` increases install size and startup time marginally.

## Open Questions

- Should `Assign` (variable binding) be in scope for a follow-on change?
- Should JSONata in Choice `Condition` be in scope here or deferred?

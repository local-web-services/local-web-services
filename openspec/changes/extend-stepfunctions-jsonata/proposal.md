# Change: Extend JSONata Support with Assign, Choice.Condition, and Credentials

## Why

The initial JSONata implementation added `Arguments` and `Output` field support. Three
additional JSONata fields required for real production state machines are not yet implemented:
`Assign` (execution-context variables), `Choice.Condition` (JSONata boolean rule evaluation),
and `Credentials.RoleArn` (dynamic role resolution). Without these, state machines that use
cross-state variable sharing, JSONata-mode Choice branching, or dynamic credentials cannot
run locally.

## What Changes

- Add `Assign` field support on Pass, Task, Choice, Wait, Succeed, Map, and Parallel states:
  evaluates `{%...%}` expressions and stores results in `$states.context.variables`,
  propagated to downstream states throughout the execution
- Add `Choice.Condition` support: when a ChoiceRule contains a `Condition` field
  (JSONata boolean expression), evaluate it instead of the JSONPath comparison operators
- Add `Credentials` field support on Task states: evaluate `{%...%}` in
  `Credentials.RoleArn` to produce a dynamic role ARN (stored on the state for audit;
  actual cross-account IAM switching is not emulated)
- Extend `jsonata_evaluator.py` with `evaluate_condition` and `evaluate_assign` helpers
- Update `asl_parser.py` to parse `Assign`, `Condition`, and `Credentials` fields
- Extend `choice_evaluator.py` to dispatch to JSONata condition evaluation
- Extend engine helpers and engine to propagate variables and resolve credentials

## Impact

- Affected specs: `stepfunctions-jsonata` (MODIFIED — new requirements added)
- Affected code:
  - `lang/python/core/src/lws/providers/stepfunctions/asl_parser.py`
  - `lang/python/core/src/lws/providers/stepfunctions/jsonata_evaluator.py`
  - `lang/python/core/src/lws/providers/stepfunctions/_engine_helpers.py`
  - `lang/python/core/src/lws/providers/stepfunctions/engine.py`
  - `lang/python/core/src/lws/providers/stepfunctions/choice_evaluator.py`
- Relevant ADRs: `adrs/adr-001-jsonata-python-library/adr.md` (consulted)

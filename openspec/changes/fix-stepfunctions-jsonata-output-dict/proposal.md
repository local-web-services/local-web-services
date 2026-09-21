# Change: Fix JSONata Output to Recurse into Dict Values

## Why

`evaluate_output` only evaluates a top-level `{%...%}` expression string. When `Output`
is a dict with `{%...%}` values, those expressions are silently returned as literal strings
instead of being evaluated. `Arguments` and `Assign` already recurse correctly via
`_expand_value`; `Output` should behave the same way.

## What Changes

- `evaluate_output` in `jsonata_evaluator.py` recurses into dict values using `_expand_value`,
  binding `$states.result` as well as `$states.input` for each leaf expression
- `_expand_value` gains an optional `result` parameter so task result is available inside
  dict-form Output values
- New Gherkin scenario in `jsonata_expression.feature` covering dict-form Output
- New E2E given step and SM definition for a dict-Output state machine
- New unit tests for dict-form Output evaluation

## Impact

- Affected specs: `stepfunctions-jsonata` (MODIFIED — extended Output requirement)
- Affected code:
  - `lang/python/core/src/lws/providers/stepfunctions/jsonata_evaluator.py`
  - `lang/specification/core/informal/stepfunctions/jsonata_expression.feature`
  - `lang/python/sdk/tests/e2e/stepfunctions/`
  - `lang/python/core/tests/integration/stepfunctions/`
- Relevant ADRs: `adrs/adr-001-jsonata-python-library/adr.md` (consulted)

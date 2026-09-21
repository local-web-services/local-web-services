# Change: Add JSONata Expression Support to Step Functions

## Why

AWS Step Functions supports JSONata as an alternative query language to JSONPath (available since
late 2024). Production state machines increasingly use `"QueryLanguage": "JSONata"` and the
`{%...%}` expression syntax for data transformation. The LWS Step Functions emulator currently
only supports JSONPath, so it cannot run these state machines locally.

## What Changes

- Add `QueryLanguage` field parsing to state machine definitions (top-level and per-state)
- Add `Arguments` field support (JSONata equivalent of `Parameters` + `InputPath`)
- Add `Output` field support (JSONata equivalent of `ResultSelector` + `ResultPath` + `OutputPath`)
- Add `jsonata-python` as a runtime dependency to evaluate `{%...%}` expressions
- New `jsonata_evaluator.py` module in the Step Functions provider
- Gherkin feature file and E2E acceptance tests exercising JSONata transformations
- Unit tests covering the evaluator and the engine in JSONata mode

## Impact

- Affected specs: `stepfunctions-jsonata` (new capability)
- Affected code:
  - `lang/python/core/src/lws/providers/stepfunctions/asl_parser.py`
  - `lang/python/core/src/lws/providers/stepfunctions/engine.py`
  - `lang/python/core/src/lws/providers/stepfunctions/_engine_helpers.py`
  - `lang/python/core/src/lws/providers/stepfunctions/jsonata_evaluator.py` (new)
  - `lang/python/core/pyproject.toml`
  - `lang/specification/core/informal/stepfunctions/jsonata_expression.feature` (new)
  - `lang/python/sdk/tests/e2e/stepfunctions/` (new step files + constants)
- Relevant ADRs: `adrs/adr-001-jsonata-python-library/adr.md` (created with this change)

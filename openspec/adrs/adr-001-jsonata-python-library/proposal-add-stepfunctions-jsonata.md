# Reference: add-stepfunctions-jsonata (proposal)

## Stage
proposal

## How This ADR Was Used
Created here — the decision was made while scaffolding the `add-stepfunctions-jsonata` proposal.

## Decision Made
Use `jsonata-python` as the JSONata evaluation library for the Step Functions provider.

## Impact
- `jsonata-python` is added as a runtime dependency in `lang/python/core/pyproject.toml`.
- The new `jsonata_evaluator.py` module imports `jsonata` and wraps it with the `$states` binding
  convention used by AWS Step Functions.
- No Node.js runtime dependency is introduced.

# Change: Fix DynamoDB Scan FilterExpression Always Returns Empty

## Status

Draft

## Problem

`Scan` with a `FilterExpression` (e.g. `Attr('x').eq('y')`) always returns
`Count=0` regardless of what is in the table. The same defect also affects
`Query` when a `FilterExpression` accompanies the key condition.

### Root cause

`apply_filter_expression` was written and unit-tested with plain Python dicts
(e.g. `{"x": "y"}`). In practice the provider passes it items fetched directly
from SQLite, which are serialised in **DynamoDB JSON format**:

```json
{"x": {"S": "y"}, "pk": {"S": "key"}}
```

Inside `ExpressionEvaluator`, `_eval_value_ref` correctly unwraps typed values
via `_unwrap_dynamo_value` (so `:val` resolves to `"y"`), but `_eval_path` and
`_eval_name_ref` return the raw DynamoDB dict `{"S": "y"}` unchanged. The
equality check `{"S": "y"} == "y"` is always `False`, so every item is filtered
out.

The same code path executes for all comparison operators, `BETWEEN`, `IN`, and
string/list functions (`begins_with`, `contains`, `size`).

## Proposed Fix

In `expressions.py`, apply `_unwrap_dynamo_value` to the value returned by
`_eval_path` and `_eval_name_ref` before returning it to the evaluator. This
makes attribute resolution symmetric with value-ref resolution.

No changes are needed in `routes.py` or `provider.py`; the fix is entirely
contained within the expression evaluator.

## Scope

| File | Change |
|---|---|
| `expressions.py` | `_eval_path` and `_eval_name_ref` unwrap DynamoDB typed values |
| `test_dynamodb_expressions_*.py` | Add DynamoDB-JSON-format items to existing expression tests |
| `test_dynamodb_provider_scan.py` | Add FilterExpression scenario |
| `test_dynamodb_provider_query.py` | Add FilterExpression scenario |
| `scan.feature` | Add `@minimal` filtered-scan scenario |

## Out of Scope

- `ProjectionExpression` support
- Nested attribute paths (dotted notation) beyond what already works
- Any other Scan/Query parameters

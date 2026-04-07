# Tasks: Fix DynamoDB Scan FilterExpression Always Returns Empty

## Ordered task list

1. **Fix `_eval_path` in `expressions.py`**
   Apply `_unwrap_dynamo_value` to the value returned when resolving an item
   attribute path. This makes attribute resolution symmetric with value-ref
   resolution.
   - File: `lang/python/core/src/lws/providers/dynamodb/expressions.py`
   - Method: `ExpressionEvaluator._eval_path`

2. **Fix `_eval_name_ref` in `expressions.py`**
   Apply `_unwrap_dynamo_value` to the value returned when resolving an
   `#alias` attribute reference.
   - File: `lang/python/core/src/lws/providers/dynamodb/expressions.py`
   - Method: `ExpressionEvaluator._eval_name_ref`

3. **Add DynamoDB-JSON-format unit tests to expression test files**
   Add test cases that use DynamoDB-typed items (e.g. `{"x": {"S": "y"}}`)
   to the existing expression evaluator unit tests, confirming equality,
   numeric comparison, `begins_with`, and `contains` all work when attribute
   values are DynamoDB-typed.
   - Files: `test_dynamodb_expressions_comparison_operators.py`,
     `test_dynamodb_expressions_expression_resolution.py`,
     `test_dynamodb_expressions_functions.py`

4. **Add FilterExpression unit tests to provider scan tests**
   Add a `test_scan_with_filter_expression_returns_matching_items` test to
   the existing `test_dynamodb_provider_scan.py`. Use DynamoDB-JSON-format
   items as they would be stored in SQLite.
   - File: `tests/unit/providers/test_dynamodb_provider_scan.py`

5. **Add FilterExpression unit tests to provider query tests**
   Add a `test_query_with_filter_expression_returns_matching_items` test to
   the existing `test_dynamodb_provider_query.py`.
   - File: `tests/unit/providers/test_dynamodb_provider_query.py`

6. **Add filtered-scan Gherkin scenario to `scan.feature`**
   Add a `@minimal @happy @scan` scenario: items are put into the table,
   a Scan with a `FilterExpression` is performed, and only matching items
   are returned.
   - File: `lang/specification/core/informal/dynamodb/scan.feature`

7. **Validate all existing tests pass**
   Run `make -C lang/python/core check` and confirm no regressions.

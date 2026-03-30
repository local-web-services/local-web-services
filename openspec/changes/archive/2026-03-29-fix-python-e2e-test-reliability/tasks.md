## 1. Neptune XML protocol

- [x] 1.1 Add `use_query_protocol: bool = False` to `ClusterDBConfig` in `cluster_db_service.py`
- [x] 1.2 Add `parse_query_body(request)` helper in `request_helpers.py` that reads `application/x-www-form-urlencoded` body and returns a plain dict (keyed by form field name)
- [x] 1.3 Add `xml_response(action, payload_dict)` helper in `response_helpers.py` that builds the standard AWS query-protocol XML envelope from a dict and returns a `Response` with `Content-Type: text/xml`
- [x] 1.4 Add `xml_error_response(code, message)` helper that returns an AWS `ErrorResponse` XML document
- [x] 1.5 Update `create_cluster_db_app` in `cluster_db_service.py` to branch on `config.use_query_protocol`: use `parse_query_body` for request parsing and `xml_response`/`xml_error_response` for all responses when `True`
- [x] 1.6 Set `use_query_protocol=True` in `_NEPTUNE_CONFIG` (`neptune/routes.py`)
- [x] 1.7 Set `use_query_protocol=True` in `_DOCDB_CONFIG` (`docdb/routes.py`) so those services are also consistent
- [x] 1.8 Add unit tests for `parse_query_body` and `xml_response` helpers
- [ ] 1.9 Run `make -C lang/python/sdk e2e-test` targeting `tests/e2e/neptune` only; confirm all 1556 failures are resolved

## 2. EventBridge `delete_rule` target guard

- [x] 2.1 In `_handle_delete_rule`, distinguish `ValueError` (targets exist) from `KeyError` (rule not found) and return `{"__type": "ValidationException", "message": "Rule can't be deleted: rule has targets"}` for the ValueError case
- [x] 2.2 Add a unit test: `test_delete_rule_with_targets_returns_validation_exception`
- [ ] 2.3 Confirm `test_an_eventbridge_rule_is_deleted_fails_when_the_rule_has_active_targets` passes

## 3. EventBridge `put_targets` e2e scenario prerequisites

- [x] 3.1 Identified that `TEST_TARGET_ARN` references Lambda function `e2e-events-func-1` which must exist before `put_targets` is called
- [x] 3.2 Added `create_target_lambda()` method to `EventsTestClient` and call it in `put_target()` before `put_targets`
- [ ] 3.3 Confirm all 37 EventBridge failures are resolved

## 4. Glacier multipart-upload step definitions

- [x] 4.1 Identified vault ARN mismatch: upload Given steps call `initiate_multipart_upload` before vault exists
- [x] 4.2 Fixed `upload_exists.py` and `upload_already_exists.py` to call `GlacierTestClient.create_vault()` before initiating the upload
- [ ] 4.3 Confirm all 26 Glacier failures are resolved

## 5. StepFunctions + SSM Given step implementations

- [x] 5.1 Identified 4 Given steps with `pytest.skip()` placeholders in `stepfunctions_ssm/given/`
- [x] 5.2 Implemented all 4 Given steps using `StepfunctionsSsmTestClient`
- [ ] 5.3 Confirm all 20 `stepfunctions_ssm` failures are resolved

## 6. Validation

- [x] 6.1 Run `make -C lang/python/sdk check` — passes lint, format, complexity, CPD, and unit tests
- [ ] 6.2 Run `make -C lang/python/sdk e2e-test` — confirm failure count drops to zero for the five targeted service modules (`neptune`, `events`, `glacier`, `stepfunctions_ssm`, and implicitly `cognito_idp`)
- [x] 6.3 Run `make -C lang/python/core unit-test` — confirmed no regressions from the XML helper additions

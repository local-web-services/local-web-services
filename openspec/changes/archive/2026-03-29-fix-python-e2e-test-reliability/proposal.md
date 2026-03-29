# Change: Fix Python e2e test suite reliability

## Why

The `python-sdk-e2e-test` CI job runs for ~46 minutes and **always fails**. Analysis of recent runs shows 2429 consistent failures across five root causes. Two require spec-level additions (Neptune uses the AWS query/XML protocol which the current emulator ignores, and EventBridge `delete_rule` lacks the AWS-required target guard); the remainder are implementation bugs introduced alongside recent cross-service dispatch work.

## What Changes

- **Neptune XML protocol**: The `cluster_db_service` shared factory always returns JSON responses. Neptune (and RDS, DocumentDB) use the AWS query protocol — requests are `application/x-www-form-urlencoded` with an `Action=` field; responses are XML. The factory must detect the protocol from a per-service config flag and route to an XML serialisation/deserialisation path. This is the root cause of **1556 Neptune failures** (`ResponseParserError: not well-formed (invalid token)`).
- **EventBridge `delete_rule` target guard**: AWS rejects `DeleteRule` with `ValidationException` when the rule still has registered targets. The current provider allows deletion unconditionally. This causes `test_an_eventbridge_rule_is_deleted_fails_when_the_rule_has_active_targets` to incorrectly pass, and leaves orphaned targets that corrupt subsequent `put_targets` / `remove_targets` scenarios (**37 EventBridge failures**).
- **EventBridge `put_targets` e2e scenario prerequisites**: The recently merged cross-service enforcement now validates that target resources (SQS queue, Lambda, SNS topic, DynamoDB table, Step Functions state machine) exist before accepting a `put_targets` call. Existing e2e scenarios for `test_targets_are_added_to_a_rule` and related tests were written before this enforcement and do not provision the target resources in their Given steps. The step definitions need updating to match the now-required preconditions.
- **Glacier multipart-upload step definitions**: `upload_already_exists.py` and `upload_exists.py` were recently refactored; the vault ARN resolution no longer matches what the provider expects, causing `ResourceNotFoundException: Vault not found` (**26 Glacier failures**).
- **StepFunctions + SSM `world` state contamination**: The `stepfunctions_ssm` step definition that reads a parameter name passes `world.get("param_name")` before it is populated, yielding `None` and triggering a boto3 `ParamValidationError` (**20 stepfunctions_ssm failures**).

## Impact

- Affected specs: `neptune-xml-protocol` (new), `python-cross-service-enforcement` (extend with `delete_rule` guard)
- Affected code: `lang/python/core/src/lws/providers/_shared/cluster_db_service.py`, `lang/python/core/src/lws/providers/_shared/response_helpers.py`, `lang/python/core/src/lws/providers/eventbridge/provider.py`, `lang/python/sdk/tests/e2e/events/`, `lang/python/sdk/tests/e2e/glacier/`, `lang/python/sdk/tests/e2e/stepfunctions_ssm/`
- No breaking changes to the public SDK or CLI.
- Resolves ~2429 e2e failures; CI job expected to pass after this change.

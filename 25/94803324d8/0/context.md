# Session Context

**Session ID:** bee54652-69ec-4f5e-ae45-2524aae1fb2a

**Commit Message:** This uncovered another issue: Workflow failed:
{
    "executionArn": "ar

## Prompt

this uncovered another issue: Workflow failed:
{
    "executionArn": "arn:aws:states:us-east-1:000000000000:execution:OrderWorkflow:e6d67eab-735e-46b2-8fd3-65e503906554",
    "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:OrderWorkflow",
    "name": "e6d67eab-735e-46b2-8fd3-65e503906554",
    "status": "FAILED",
    "startDate": 1771000290.4843771,
    "stopDate": 1771000294.849938,
    "error": "States.TaskFailed",
    "cause": "Expected object, got string: PROCESSED\n  Deserialization error: to see the raw response, inspect the hidden field {error}.$response on this object."
}

## Summary

All 2018 tests pass. Here's a summary of both fixes:

**1. `src/lws/providers/lambda_runtime/docker.py`** — Added `NODE_PATH=/var/runtime/node_modules` so Node.js Lambdas can `require('@aws-sdk/...')` without bundling.

**2. `src/lws/providers/dynamodb/provider.py`** — Fixed the DynamoDB `update_item` response format. The update expression evaluator unwraps DynamoDB-typed values (e.g., `{"S": "PROCESSED"}` → `"PROCESSED"`) when applying SET actions, creating a mixed-format item. Added `_ensure_dynamo_json` / `_ensure_dynamo_json_value` helpers that re-wrap any plain values back to DynamoDB JSON after the evaluator runs. This fixes both the HTTP response (so SDK v3 can deserialize it) and the stored data (so subsequent GetItem/Query calls also return correct format).

## Key Actions

- - **Task**: Find DynamoDB UpdateItem handler
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/provider.py
- - **Grep**: _to_dynamo_json|to_dynamo|_marshal|_serialize|typed_to_|_to_typed
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/provider.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/routes.py
- - **Grep**: def apply_update_expression
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/provider.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/provider.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/update_expression.py

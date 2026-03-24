# Change: Cross-Service Dispatch Phase 2

## Why

After Phase 1, 995 Python SDK E2E scenarios remain skipped across 7 capability areas. These skips represent real AWS behaviours that lws claims to emulate but does not yet enforce: S3→Lambda notification dispatch, S3→EventBridge SDK configuration, StepFunctions guard validations, DynamoDB stream triggers, Lambda async invocation observability, API Gateway service integrations, and the RDS Data API. Eliminating these skips brings lws closer to a zero-skip test suite and closes the remaining cross-service dispatch gaps identified in Phase 1.

## What Changes

- **S3→EventBridge SDK config (Phase A):** Implement missing step definitions in `s3api_events/conftest.py` — no core changes needed, core already dispatches.
- **S3→Lambda dispatch (Phase B):** Extend Python S3 notification validation to accept Lambda ARNs; add Lambda dispatch case to Go and TypeScript S3 handlers; remove 13 Python SDK skips.
- **StepFunctions guard validation (Phase C):** Add pre-execution checks (state machine status, target resource existence, capacity) to the Python StepFunctions service task bridge; remove ~40 SDK skips across 7 suites.
- **Lambda invocation observability (Phase D):** Add async invocation mode (`Event` InvocationType) and invocation state tracking (IN_PROGRESS → SUCCESS/FAILED) to the Python Lambda provider; remove ~50 SDK skips.
- **DynamoDB stream → Lambda (Phase E):** Emit stream records on item mutations when an event source mapping exists; complete stream polling in `event_source_manager.py`; remove 12 SDK skips. **BREAKING** for DynamoDB provider internal API.
- **API Gateway service integrations (Phase F):** Implement AWS-type integration execution (URI parsing + backend dispatch) for DynamoDB, SQS, SNS, S3, and StepFunctions in the V1 REST API provider; remove ~80 SDK skips.
- **RDS Data API (Phase G):** Implement `POST /execute` (ExecuteStatement) with a SQLite-per-cluster backend; remove 198 SDK skips.

## Impact

- Affected specs: `s3-lambda-notifications`, `s3-eventbridge-notifications`, `stepfunctions-guard-validation`, `dynamodb-stream-lambda`, `lambda-invocation-observability`, `apigateway-service-integrations`, `rds-data-api`
- Affected code: `lang/python/core/src/lws/providers/s3/`, `lang/python/core/src/lws/providers/stepfunctions/`, `lang/python/core/src/lws/providers/lambda_runtime/`, `lang/python/core/src/lws/providers/dynamodb/`, `lang/python/core/src/lws/providers/apigateway/`, `lang/python/core/src/lws/providers/rds/`, `lang/go/core/lws/providers/s3/`, `lang/typescript/core/src/providers/s3/`, `lang/python/sdk/tests/e2e/` (17 conftest files)
- Estimated skip reduction: ~399 fewer Python SDK skips (6 + 13 + 40 + 50 + 12 + 80 + 198)

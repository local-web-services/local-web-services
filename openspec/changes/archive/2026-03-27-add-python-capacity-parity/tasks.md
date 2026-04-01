## 1. Shared Capacity Infrastructure

- [x] 1.1 Add `check_capacity(config, error_code, status_code)` helper to `_shared/aws_capacity.py` that returns a `JSONResponse` when exhausted and `None` otherwise
- [x] 1.2 Create `_shared/capacity_control.py` with a `register_capacity_routes(router, capacity_configs)` function that mounts `GET`, `PUT`, and `DELETE` handlers at `/_lws/control/{service}/capacity`
- [x] 1.3 Write unit tests for `check_capacity()` covering: returns `None` when `slots=None`, returns error response when `slots=0`
- [x] 1.4 Write unit tests for the control plane router covering: PUT exhausts, DELETE resets to unlimited, GET returns current config, unknown service returns 404

## 2. DynamoDB

- [x] 2.1 Wire capacity check in `GetItem`, `Query`, `Scan`, `UpdateItem`, `DeleteItem`, `TransactWriteItems`, `BatchGetItem` (PutItem and BatchWriteItem already guarded)
- [x] 2.2 Register the DynamoDB `AwsCapacityConfig` with the shared capacity router under `"dynamodb"`
- [x] 2.3 Write unit tests for each guarded operation
- [x] 2.4 Run DynamoDB unit, integration, and E2E tests

## 3. Lambda

- [x] 3.1 Add separate `_concurrency_capacity` and `_async_capacity` configs to the Lambda provider
- [x] 3.2 Wire concurrency-slot check in `Invoke` (synchronous path) using `_concurrency_capacity`
- [x] 3.3 Wire async-slot check in async invocation and event-driven delivery paths using `_async_capacity`
- [x] 3.4 Register both configs with the capacity router under `"lambda"` and `"lambda-async"` respectively
- [x] 3.5 Write unit tests for both capacity paths
- [x] 3.6 Run Lambda unit, integration, and E2E tests

## 4. SQS

- [x] 4.1 Verify existing capacity enforcement covers `SendMessage` and `SendMessageBatch`; add any missing operations
- [x] 4.2 Register the SQS `AwsCapacityConfig` with the shared capacity router under `"sqs"`
- [x] 4.3 Write unit tests for guarded operations
- [x] 4.4 Run SQS unit, integration, and E2E tests

## 5. SNS

- [x] 5.1 Wire capacity check in `Publish`; `slots=0` returns `KMSThrottlingException` (HTTP 400)
- [x] 5.2 Wire capacity check in `Subscribe`; `slots=0` returns throttle error
- [x] 5.3 Wire capacity check in cross-service delivery paths (SNS → Lambda, SNS → SQS); check destination service capacity in addition to SNS capacity
- [x] 5.4 Register the SNS `AwsCapacityConfig` with the capacity router under `"sns"`
- [x] 5.5 Run SNS unit, integration, and E2E tests

## 6. Cognito

- [x] 6.1 Wire capacity check in `InitiateAuth`; `slots=0` returns `TooManyRequestsException` (HTTP 400)
- [x] 6.2 Wire capacity check in `SignUp`; `slots=0` returns `TooManyRequestsException`
- [x] 6.3 Register the Cognito `AwsCapacityConfig` with the capacity router under `"cognito"`
- [x] 6.4 Run Cognito unit, integration, and E2E tests

## 7. Step Functions

- [x] 7.1 Wire capacity check in `StartExecution`; `slots=0` returns `ServiceUnavailableException` (HTTP 503)
- [x] 7.2 Register the Step Functions `AwsCapacityConfig` with the capacity router under `"stepfunctions"`
- [x] 7.3 Run Step Functions unit, integration, and E2E tests

## 8. API Gateway

- [x] 8.1 Wire capacity check on all REST API invocation paths; `slots=0` returns HTTP 429 with no body
- [x] 8.2 Register the API Gateway `AwsCapacityConfig` with the capacity router under `"apigateway"`
- [x] 8.3 Run API Gateway unit, integration, and E2E tests

## 9. Glacier

- [x] 9.1 Wire capacity check in `InitiateJob`; `slots=0` returns `ServiceUnavailableException` (HTTP 503)
- [x] 9.2 Wire capacity check in `UploadArchive`; `slots=0` returns `ServiceUnavailableException`
- [x] 9.3 Register the Glacier `AwsCapacityConfig` with the capacity router under `"glacier"`
- [x] 9.4 Run Glacier unit, integration, and E2E tests

## 10. Validation

- [x] 10.1 Run the full Python test suite (`make unit-test integration-test test-e2e`) with default unlimited capacity
- [x] 10.2 Run the full Python test suite with each service set to `slots=0` to verify capacity rejection paths
- [x] 10.3 Verify CPD (Symilar) passes — confirm the `check_capacity()` helper absorbed the duplicate guard patterns

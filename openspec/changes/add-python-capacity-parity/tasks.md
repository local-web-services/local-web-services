## 1. Shared Capacity Infrastructure

- [ ] 1.1 Add `check_capacity(config, error_code, status_code)` helper to `_shared/aws_capacity.py` that returns a `JSONResponse` when exhausted and `None` otherwise
- [ ] 1.2 Create `_shared/capacity_control.py` with a `register_capacity_routes(router, capacity_configs)` function that mounts `GET`, `PUT`, and `DELETE` handlers at `/_lws/control/{service}/capacity`
- [ ] 1.3 Write unit tests for `check_capacity()` covering: returns `None` when `slots=None`, returns error response when `slots=0`
- [ ] 1.4 Write unit tests for the control plane router covering: PUT exhausts, DELETE resets to unlimited, GET returns current config, unknown service returns 404

## 2. DynamoDB

- [ ] 2.1 Wire capacity check in `GetItem`, `Query`, `Scan`, `UpdateItem`, `DeleteItem`, `TransactWriteItems`, `BatchGetItem` (PutItem and BatchWriteItem already guarded)
- [ ] 2.2 Register the DynamoDB `AwsCapacityConfig` with the shared capacity router under `"dynamodb"`
- [ ] 2.3 Write unit tests for each guarded operation
- [ ] 2.4 Run DynamoDB unit, integration, and E2E tests

## 3. Lambda

- [ ] 3.1 Add separate `_concurrency_capacity` and `_async_capacity` configs to the Lambda provider
- [ ] 3.2 Wire concurrency-slot check in `Invoke` (synchronous path) using `_concurrency_capacity`
- [ ] 3.3 Wire async-slot check in async invocation and event-driven delivery paths using `_async_capacity`
- [ ] 3.4 Register both configs with the capacity router under `"lambda"` and `"lambda-async"` respectively
- [ ] 3.5 Write unit tests for both capacity paths
- [ ] 3.6 Run Lambda unit, integration, and E2E tests

## 4. SQS

- [ ] 4.1 Verify existing capacity enforcement covers `SendMessage` and `SendMessageBatch`; add any missing operations
- [ ] 4.2 Register the SQS `AwsCapacityConfig` with the shared capacity router under `"sqs"`
- [ ] 4.3 Write unit tests for guarded operations
- [ ] 4.4 Run SQS unit, integration, and E2E tests

## 5. SNS

- [ ] 5.1 Wire capacity check in `Publish`; `slots=0` returns `KMSThrottlingException` (HTTP 400)
- [ ] 5.2 Wire capacity check in `Subscribe`; `slots=0` returns throttle error
- [ ] 5.3 Wire capacity check in cross-service delivery paths (SNS → Lambda, SNS → SQS); check destination service capacity in addition to SNS capacity
- [ ] 5.4 Register the SNS `AwsCapacityConfig` with the capacity router under `"sns"`
- [ ] 5.5 Run SNS unit, integration, and E2E tests

## 6. Cognito

- [ ] 6.1 Wire capacity check in `InitiateAuth`; `slots=0` returns `TooManyRequestsException` (HTTP 400)
- [ ] 6.2 Wire capacity check in `SignUp`; `slots=0` returns `TooManyRequestsException`
- [ ] 6.3 Register the Cognito `AwsCapacityConfig` with the capacity router under `"cognito"`
- [ ] 6.4 Run Cognito unit, integration, and E2E tests

## 7. Step Functions

- [ ] 7.1 Wire capacity check in `StartExecution`; `slots=0` returns `ServiceUnavailableException` (HTTP 503)
- [ ] 7.2 Register the Step Functions `AwsCapacityConfig` with the capacity router under `"stepfunctions"`
- [ ] 7.3 Run Step Functions unit, integration, and E2E tests

## 8. API Gateway

- [ ] 8.1 Wire capacity check on all REST API invocation paths; `slots=0` returns HTTP 429 with no body
- [ ] 8.2 Register the API Gateway `AwsCapacityConfig` with the capacity router under `"apigateway"`
- [ ] 8.3 Run API Gateway unit, integration, and E2E tests

## 9. Glacier

- [ ] 9.1 Wire capacity check in `InitiateJob`; `slots=0` returns `ServiceUnavailableException` (HTTP 503)
- [ ] 9.2 Wire capacity check in `UploadArchive`; `slots=0` returns `ServiceUnavailableException`
- [ ] 9.3 Register the Glacier `AwsCapacityConfig` with the capacity router under `"glacier"`
- [ ] 9.4 Run Glacier unit, integration, and E2E tests

## 10. Validation

- [ ] 10.1 Run the full Python test suite (`make unit-test integration-test test-e2e`) with default unlimited capacity
- [ ] 10.2 Run the full Python test suite with each service set to `slots=0` to verify capacity rejection paths
- [ ] 10.3 Verify CPD (Symilar) passes — confirm the `check_capacity()` helper absorbed the duplicate guard patterns

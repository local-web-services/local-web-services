# Change: Add Full Capacity Parity to Python Core Provider

## Why

The FizzBee formal specs model capacity constraints (`guard_violation_capacity:` annotations) for 8 services: DynamoDB (read/write throttling), Lambda (concurrency slots, async slots), SQS (message slots), SNS (subscription/delivery slots), Cognito (session slots), Step Functions (execution slots), API Gateway (request/resource slots), and Glacier (archive/job slots). The Python core provider has a shared `AwsCapacityConfig` abstraction in `_shared/aws_capacity.py` and a management endpoint at `/_ldk/capacity`, but capacity enforcement is only wired into a subset of services (DynamoDB, Lambda, SQS). Every other service that has `guard_violation_capacity:` annotations in the formal spec returns success regardless of configured capacity limits.

Additionally, the existing management endpoint lives at `/_ldk/capacity` (a legacy namespace) rather than the `/_lws/control/` namespace used by the new lifecycle control plane. Capacity control should follow the same RESTful control plane pattern as lifecycle state overrides.

## What Changes

- **Control plane endpoint** — Add `PUT /_lws/control/{service}/capacity` with body `{"slots": 0|null}` and `DELETE /_lws/control/{service}/capacity` to reset to unlimited; implemented once in `_shared/capacity_control.py` and mounted by each provider; deprecate `/_ldk/capacity` in favour of the new endpoint
- **SNS** — Wire capacity check in `Publish`, `Subscribe`, and cross-service delivery paths; `slots=0` returns `KMSThrottlingException` or equivalent throttle error
- **Cognito** — Wire capacity check in `InitiateAuth` and `SignUp`; `slots=0` returns `TooManyRequestsException`
- **Step Functions** — Wire capacity check in `StartExecution`; `slots=0` returns `ServiceUnavailableException`
- **API Gateway** — Wire capacity check on all REST API invocation paths; `slots=0` returns `429 Too Many Requests`
- **Glacier** — Wire capacity check in `InitiateJob` and `UploadArchive`; `slots=0` returns `ServiceUnavailableException`
- **DynamoDB** — Extend existing enforcement to cover `Query`, `Scan`, `UpdateItem`, `DeleteItem`, `TransactWriteItems`, `BatchGetItem` (currently only `PutItem` and `BatchWriteItem` are guarded)
- **Lambda** — Extend existing enforcement to cover async invocations and event source mapping delivery paths; add separate concurrency-slot and async-slot checks matching the fizz spec model
- **Defaults** — All services default to `slots=None` (unlimited); no behaviour change at default settings

## Impact

- Affected specs: `python-capacity-parity`
- Affected code: `lang/python/core/src/lws/providers/` (all 8 services listed above), `lang/python/core/src/lws/providers/_shared/aws_capacity.py`, new `lang/python/core/src/lws/providers/_shared/capacity_control.py`
- **NON-BREAKING**: Default `slots=None` (unlimited) preserves all existing test behaviour; capacity limits only activate when explicitly configured via the control plane

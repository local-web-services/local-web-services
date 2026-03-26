# Tasks: add-python-fake-chaos-sdk-access

## 1. SDK session — fake service clients

- [ ] 1.1 Register fake and aws_fake service endpoint URLs in `LwsSession`
- [ ] 1.2 Make `lws_session.client("fake")` return a boto3 client for the fake service
- [ ] 1.3 Make `lws_session.client("aws_fake")` return a boto3 client for the aws_fake service
- [ ] 1.4 Unit tests for client construction

## 2. SDK session — chaos helpers

- [ ] 2.1 Add `set_chaos(service, error_rate=1.0, latency_ms=0)` calling `PUT /management/chaos/{service}`
- [ ] 2.2 Add `reset_chaos(service)` calling `DELETE /management/chaos/{service}`
- [ ] 2.3 Add `get_chaos_status(service)` calling `GET /management/chaos/{service}`
- [ ] 2.4 Unit tests for chaos helpers

## 3. Core — chaos management API endpoint

- [ ] 3.1 Add `PUT /management/chaos/{service}` accepting `{"error_rate": float, "latency_ms": int}`
- [ ] 3.2 Add `DELETE /management/chaos/{service}` to reset chaos config
- [ ] 3.3 Add `GET /management/chaos/{service}` to return current config
- [ ] 3.4 Wire into `create_management_router`
- [ ] 3.5 Unit tests for management API

## 4. E2E steps — fake and chaos suites

- [ ] 4.1 Implement all skipped given/when/then steps in `tests/e2e/fake/`
- [ ] 4.2 Implement all skipped given/when/then steps in `tests/e2e/aws_fake/`
- [ ] 4.3 Implement chaos given steps (set error rate to 1.0, set latency) in `tests/e2e/chaos/`
- [ ] 4.4 Implement chaos then steps (assert rejection when error rate is full, assert latency)
- [ ] 4.5 Add chaos teardown fixture to reset chaos after each test

## 5. Quality checks

- [ ] 5.1 `make check` passes for `lang/python/core`
- [ ] 5.2 `make check` passes for `lang/python/sdk`
- [ ] 5.3 All formerly-skipped fake/chaos steps now pass

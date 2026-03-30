# Tasks: add-python-fake-chaos-sdk-access

## 1. SDK session — fake service clients

- [x] 1.1 Register fake and aws_fake service endpoint URLs in `LwsSession`
- [x] 1.2 Make `lws_session.client("fake")` return a `FakeServerClient` for the fake service
- [x] 1.3 Make `lws_session.client("aws_fake")` return an `AwsFakeClient` for the aws_fake service
- [x] 1.4 Unit tests for client construction

## 2. SDK session — chaos helpers

- [x] 2.1 Add `set_chaos(service, error_rate=1.0, latency_ms=0)` calling `PUT /_ldk/chaos/{service}`
- [x] 2.2 Add `reset_chaos(service)` calling `DELETE /_ldk/chaos/{service}`
- [x] 2.3 Add `get_chaos_status(service)` calling `GET /_ldk/chaos/{service}`
- [x] 2.4 Unit tests for chaos helpers

## 3. Core — chaos management API endpoint

- [x] 3.1 Add `PUT /_ldk/chaos/{service}` accepting `{"error_rate": float, "latency_ms": int}`
- [x] 3.2 Add `DELETE /_ldk/chaos/{service}` to reset chaos config
- [x] 3.3 Add `GET /_ldk/chaos/{service}` to return current config
- [x] 3.4 Wire into `create_management_router`
- [x] 3.5 Unit tests for management API

## 4. E2E steps — fake and chaos suites

- [x] 4.1 Implement all skipped given/when/then steps in `tests/e2e/fake/`
- [x] 4.2 Implement all skipped given/when/then steps in `tests/e2e/aws_fake/`
- [x] 4.3 Chaos given steps use existing `lws_session.chaos()` / `set_chaos()` helpers
- [x] 4.4 Three chaos negative steps remain intentionally skipped (LWS does not enforce at spec boundary)
- [x] 4.5 Chaos teardown handled by existing `reset_lws_between_scenarios` autouse fixture

## 5. Quality checks

- [x] 5.1 `make check` passes for `lang/python/core`
- [x] 5.2 `make check` passes for `lang/python/sdk`
- [x] 5.3 All formerly-skipped fake/aws_fake steps now pass

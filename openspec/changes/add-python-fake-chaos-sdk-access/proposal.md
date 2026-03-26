# Change: Add Python fake/chaos service access from SDK test session

## Why

~60 e2e step definitions are skipped because `LwsSession` does not expose a boto3 client for the fake/chaos services, and the management API for configuring chaos mode (error rate, latency injection) and fake service behaviour is not accessible from test step definitions. The core providers exist and work; the gap is purely in the SDK session layer.

## What Changes

- **SDK**: Add `lws_session.client("fake")` and `lws_session.client("aws_fake")` to return boto3 clients pointed at the fake service endpoints.
- **SDK**: Add `lws_session.set_chaos(service, error_rate, latency_ms)` and `lws_session.reset_chaos(service)` helpers that call the core chaos management API.
- **SDK**: Add `lws_session.get_chaos_status(service)` to retrieve current chaos configuration.
- **Core**: Ensure the fake service management API endpoint (`PUT /management/chaos/{service}`) is exposed per service and accepts error rate (0.0–1.0) and latency (ms).
- **E2E steps**: Replace `pytest.skip()` with real implementations in the `fake/`, `aws_fake/`, and `chaos/` step suites.

## Impact

- Affected specs: `python-fake-chaos-sdk-access` (new)
- Affected code: `lang/python/sdk/src/lws_testing/session.py`, `lang/python/core/src/lws/providers/_shared/aws_chaos.py`, `lang/python/core/src/lws/cli/_ldk_http_registry.py`
- No breaking changes.

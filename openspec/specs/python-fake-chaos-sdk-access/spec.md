# python-fake-chaos-sdk-access Specification

## Purpose
TBD - created by archiving change add-python-fake-chaos-sdk-access. Update Purpose after archive.
## Requirements
### Requirement: Fake Service SDK Client

The `LwsSession` object SHALL support `lws_session.client("fake")` and `lws_session.client("aws_fake")` returning boto3 clients pointed at the respective fake service endpoints, consistent with how `lws_session.client("sqs")` works for real service endpoints.

#### Scenario: Fake client returns a usable boto3 client

- **GIVEN** an `LwsSession` is active
- **WHEN** `lws_session.client("fake")` is called
- **THEN** a boto3 client is returned that can make requests to the fake service

### Requirement: Chaos Management SDK Helpers

The `LwsSession` object SHALL expose `set_chaos(service, error_rate, latency_ms)`, `reset_chaos(service)`, and `get_chaos_status(service)` methods that call the core chaos management API, allowing e2e step definitions to inject and remove failures without restarting lws.

#### Scenario: Error injection causes rejection

- **GIVEN** `lws_session.set_chaos("sqs", error_rate=1.0)` has been called
- **WHEN** any SQS operation is performed
- **THEN** it is rejected with the configured error

#### Scenario: Chaos reset restores normal operation

- **GIVEN** chaos has been configured for a service
- **WHEN** `lws_session.reset_chaos("sqs")` is called
- **THEN** subsequent SQS operations succeed normally

### Requirement: Chaos Management API

The core management API SHALL expose `PUT /management/chaos/{service}` accepting `{"error_rate": float, "latency_ms": int}`, `DELETE /management/chaos/{service}` to reset, and `GET /management/chaos/{service}` to retrieve current configuration.

#### Scenario: Chaos configuration accepted

- **WHEN** `PUT /management/chaos/lambda` is called with `{"error_rate": 1.0, "latency_ms": 200}`
- **THEN** the configuration is stored and subsequent Lambda invocations fail with the configured error

#### Scenario: Chaos configuration retrieved

- **GIVEN** chaos has been configured
- **WHEN** `GET /management/chaos/lambda` is called
- **THEN** the current error_rate and latency_ms are returned


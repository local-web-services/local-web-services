# Spec Delta: python-e2e-skip-removal

## Target spec: python-capacity-parity

## ADDED Requirements

### Requirement: All capacity-guarded e2e scenarios are runnable without pytest.skip

The Python SDK e2e test suite SHALL NOT call `pytest.skip()` for the reason "Cannot exhaust … slot limit" in any step definition. Every service that ships an `AwsCapacityConfig` SHALL have corresponding step definitions that call `lws_session.capacity("<service>").exhaust().apply()` to exhaust capacity before the test and `lws_session.capacity("<service>").clear()` to restore it after. Services that lack `AwsCapacityConfig` SHALL have it added before the corresponding step definitions are implemented.

#### Scenario: Capacity step runs without skip for Lambda

- **GIVEN** a `no_invocation_slot_available` step definition exists in any e2e suite that targets Lambda
- **WHEN** the scenario is collected and run
- **THEN** `lws_session.capacity("lambda").exhaust().apply()` is called and no `pytest.skip()` is raised

#### Scenario: Capacity step runs without skip for StepFunctions

- **GIVEN** a `no_execution_slot_available` step definition exists in any e2e suite that targets StepFunctions
- **WHEN** the scenario is collected and run
- **THEN** `lws_session.capacity("stepfunctions").exhaust().apply()` is called and no `pytest.skip()` is raised

#### Scenario: Capacity step runs without skip for EventBridge

- **GIVEN** a `no_event_slot_available` step definition exists in any e2e suite that targets EventBridge
- **WHEN** the scenario is collected and run
- **THEN** `lws_session.capacity("events").exhaust().apply()` is called and no `pytest.skip()` is raised

#### Scenario: Capacity step runs without skip for SNS

- **GIVEN** a `subscription_slot_not_available` or `delivery_slot_not_available` step definition exists
- **WHEN** the scenario is collected and run
- **THEN** `lws_session.capacity("sns").exhaust().apply()` is called and no `pytest.skip()` is raised

---

### Requirement: `@internal` e2e scenarios are collected and run

The Python SDK e2e `conftest.py` SHALL NOT filter out `@internal`-tagged scenarios from pytest collection. All `@internal` scenarios SHALL be visible in test results. Scenarios whose step definitions call `pytest.skip()` due to unimplemented cross-service dispatch or lifecycle state injection SHALL show as SKIPPED (not omitted).

#### Scenario: @internal @capacity scenario passes after capacity step is implemented

- **GIVEN** a scenario is tagged `@internal @capacity`
- **AND** the capacity step definition is implemented using `lws_session.capacity()`
- **WHEN** the test suite runs
- **THEN** the scenario shows as PASSED (not SKIPPED, not omitted)

#### Scenario: @internal cross-service scenario is visible as SKIPPED

- **GIVEN** a scenario is tagged `@internal` but not `@capacity`
- **AND** its step definition calls `pytest.skip("Cannot trigger …")`
- **WHEN** the test suite runs
- **THEN** the scenario shows as SKIPPED with the informative message (not omitted from results)

---

### Requirement: OpenSearch, MemoryDB, ElastiCache, Neptune, DocumentDB, and SSM expose capacity control

The OpenSearch, Elasticsearch, MemoryDB, ElastiCache, Neptune, DocumentDB, and SSM providers SHALL each wire `AwsCapacityConfig` and mount the `CapacityControlPlane` endpoint so that `lws_session.capacity("<service>").exhaust().apply()` succeeds and causes capacity-guarded operations to return the service-specific capacity error code.

#### Scenario: OpenSearch rejects document indexing when capacity exhausted

- **GIVEN** `lws_session.capacity("opensearch").exhaust().apply()` is called
- **WHEN** a document indexing operation is attempted
- **THEN** the service returns the capacity error response

#### Scenario: MemoryDB rejects cluster creation when capacity exhausted

- **GIVEN** `lws_session.capacity("memorydb").exhaust().apply()` is called
- **WHEN** a cluster creation operation is attempted
- **THEN** the service returns the capacity error response

#### Scenario: ElastiCache rejects instance creation when capacity exhausted

- **GIVEN** `lws_session.capacity("elasticache").exhaust().apply()` is called
- **WHEN** an instance creation operation is attempted
- **THEN** the service returns the capacity error response

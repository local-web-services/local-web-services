## ADDED Requirements

### Requirement: SDK Capacity Control

The `LwsSession` object SHALL expose `set_capacity(service, slots)` and `reset_capacity(service)` methods that call the core management API to set or remove a per-service slot limit, allowing e2e step definitions to simulate exhausted capacity without modifying lws startup configuration.

#### Scenario: Capacity exhaustion step sets slots to zero

- **GIVEN** an `LwsSession` is active
- **WHEN** `lws_session.set_capacity("lambda", 0)` is called
- **THEN** subsequent Lambda invoke calls return `TooManyRequestsException` (429)

#### Scenario: Capacity reset restores normal operation

- **GIVEN** capacity has been set to zero for a service
- **WHEN** `lws_session.reset_capacity("lambda")` is called
- **THEN** subsequent Lambda invoke calls succeed normally

### Requirement: SDK Resource Lifecycle Control

The `LwsSession` object SHALL expose `set_resource_lifecycle(service, resource_name, state)` and `reset_resource_lifecycle(service, resource_name)` methods that call the core management API to place a named resource into a synthetic lifecycle state (e.g. CREATING, DELETING), allowing e2e step definitions to test non-ACTIVE resource behaviour without dwell-time races.

#### Scenario: Resource placed into CREATING state

- **GIVEN** a resource exists and is ACTIVE
- **WHEN** `lws_session.set_resource_lifecycle("dynamodb", "my-table", "CREATING")` is called
- **THEN** read/write operations against `my-table` return `ResourceNotFoundException` or lifecycle-appropriate error

#### Scenario: Resource lifecycle reset restores ACTIVE state

- **GIVEN** a resource is in a synthetic CREATING state
- **WHEN** `lws_session.reset_resource_lifecycle("dynamodb", "my-table")` is called
- **THEN** read/write operations against `my-table` succeed normally

### Requirement: Lifecycle Wiring — All Remaining Services

The following services SHALL have `ResourceLifecycleConfig` / `ResourceStateTracker` wired so that resources can be placed into CREATING, ACTIVE, and DELETING (or equivalent) states via the management API:

- Lambda (function states: PENDING, ACTIVE, INACTIVE, FAILED)
- OpenSearch / Elasticsearch (domain states: CREATING, ACTIVE, DELETING)
- ElastiCache (cluster states: CREATING, AVAILABLE, MODIFYING, DELETING)
- Neptune (cluster states: CREATING, AVAILABLE, STOPPING, STOPPED, DELETING)
- RDS (instance states: CREATING, AVAILABLE, MODIFYING, STOPPING, STOPPED, FAILING_OVER, DELETING)
- DocumentDB (cluster states: CREATING, AVAILABLE, MODIFYING, DELETING)
- MemoryDB (cluster, snapshot, ACL, user states)
- Glacier (vault states: CREATING, ACTIVE, DELETING; archive state: STORED)
- Cognito (user pool states: CREATING, ACTIVE, DELETING)
- S3 (bucket states: CREATING, ACTIVE, DELETING)
- S3 Tables (table bucket and table states: CREATING, ACTIVE, DELETING)
- ApiGateway (REST API states: CREATING, ACTIVE, DELETING)
- StepFunctions (state machine states: CREATING, ACTIVE, DELETING)

#### Scenario: Non-ACTIVE resource rejects operations

- **GIVEN** a service has lifecycle wiring enabled
- **WHEN** a resource is placed into CREATING or DELETING state via the management API
- **THEN** API operations that require ACTIVE state return the service-appropriate error (e.g. `ResourceInUseException`, `InvalidStateException`)

#### Scenario: Operations succeed when resource is ACTIVE

- **GIVEN** a resource exists in ACTIVE state
- **WHEN** normal API operations are performed
- **THEN** they succeed as expected

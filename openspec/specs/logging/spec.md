# logging Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Structured Request Logging
LDK SHALL log all handler invocations to the terminal with structured output showing the trigger source, handler name, duration, and outcome.

#### Scenario: HTTP request logged
- **WHEN** an HTTP request triggers a Lambda handler
- **THEN** the terminal SHALL display the HTTP method, path, handler name, response status code, and duration (e.g., `POST /orders -> createOrder (234ms) -> 201`)

#### Scenario: Queue message logged
- **WHEN** an SQS message triggers a Lambda handler
- **THEN** the terminal SHALL display the queue name, handler name, message count, and duration

### Requirement: SDK Call Instrumentation
LDK SHALL instrument all AWS SDK calls made by handlers and display them in the terminal output, showing which services were called, what operations were performed, and what resources were accessed.

#### Scenario: DynamoDB call traced
- **WHEN** a handler calls `dynamodb.put_item()` on a table named `OrdersTable`
- **THEN** the terminal SHALL display `DynamoDB PutItem: OrdersTable` with the key values used

#### Scenario: SQS call traced
- **WHEN** a handler calls `sqs.send_message()` to a queue named `OrderQueue`
- **THEN** the terminal SHALL display `SQS SendMessage: OrderQueue`

### Requirement: Request Flow Tracing
LDK SHALL display the complete flow of a request through the application, showing the chain of handler invocations, SDK calls, and downstream triggers in a hierarchical trace format.

#### Scenario: End-to-end trace displayed
- **WHEN** an HTTP POST creates an order (DynamoDB put), sends a message to SQS, which triggers a processing handler
- **THEN** the terminal SHALL display a hierarchical trace showing: the HTTP request, the DynamoDB write, the SQS send, and the downstream handler invocation with their respective timings

### Requirement: Error Logging with Context
LDK SHALL display clear error messages when handlers fail, including the handler name, the event payload that caused the error, and the full stack trace.

#### Scenario: Handler error logged
- **WHEN** a handler throws an unhandled exception
- **THEN** the terminal SHALL display the handler name, the event payload, and the full stack trace with source file locations

### Requirement: Hot Reload Logging
LDK SHALL log file change detection and reload events to the terminal, showing which files changed and how long the reload took.

#### Scenario: Reload event logged
- **WHEN** a handler file is modified and reloaded
- **THEN** the terminal SHALL display the changed file path and the reload duration (e.g., `Changed: src/handlers/createOrder.py - Reloaded in 120ms`)

### Requirement: Configurable Log Level
LDK SHALL support configurable log verbosity levels (debug, info, warn, error) via the configuration file.

#### Scenario: Debug level shows SDK details
- **WHEN** the log level is set to `debug`
- **THEN** full request and response payloads for SDK calls SHALL be displayed

#### Scenario: Warn level suppresses info
- **WHEN** the log level is set to `warn`
- **THEN** only warnings and errors SHALL be displayed, suppressing routine request and reload logs

### Requirement: WebSocket Log Streaming
The logging system SHALL provide a `WebSocketLogHandler` that captures structured log entries from `LdkLogger` and publishes them to connected WebSocket clients. Each log entry SHALL be a JSON object containing at minimum `timestamp`, `level`, and `message` fields. The handler SHALL maintain a bounded buffer of recent entries (default 500) and send the backlog to newly connected clients before streaming live entries. When no clients are connected, the handler SHALL continue buffering without error.

#### Scenario: Client receives live log entries
- **WHEN** a WebSocket client connects to the log streaming endpoint and a handler invocation occurs
- **THEN** the client SHALL receive a JSON log entry with `timestamp`, `level`, `message`, and any structured fields such as `method`, `path`, `handler`, `duration_ms`, `status_code`

#### Scenario: Client receives backlog on connect
- **WHEN** a WebSocket client connects and log entries already exist in the buffer
- **THEN** the client SHALL receive all buffered entries before receiving new live entries

#### Scenario: No clients connected
- **WHEN** no WebSocket clients are connected and log entries are produced
- **THEN** the handler SHALL buffer entries up to the configured limit without error


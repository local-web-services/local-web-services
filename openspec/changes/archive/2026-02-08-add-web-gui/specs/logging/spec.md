## ADDED Requirements
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

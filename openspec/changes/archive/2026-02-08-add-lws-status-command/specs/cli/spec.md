## ADDED Requirements
### Requirement: LWS Status Command
The `lws` CLI SHALL provide a `status` command that displays the current state of the running `ldk dev` instance. The command SHALL query the management API endpoints `GET /_ldk/status` and `GET /_ldk/resources`. By default the output SHALL be a human-readable table showing the overall LDK running state, each provider with its health status, and each service with its port and resource count. When `--json` is passed the output SHALL be JSON. If `ldk dev` is not running, the command SHALL print an error message and exit with code 1.

#### Scenario: Show status as table by default
- **WHEN** a developer runs `lws status` while `ldk dev` is running
- **THEN** the output SHALL be a human-readable table showing that LDK is running, listing each provider with a healthy/unhealthy indicator, and listing each service with its port and resource count

#### Scenario: Show status as JSON
- **WHEN** a developer runs `lws status --json` while `ldk dev` is running
- **THEN** the output SHALL be a JSON object containing `running`, `providers`, and `services` keys

#### Scenario: Show error when ldk dev is not running
- **WHEN** a developer runs `lws status` and `ldk dev` is not running
- **THEN** the command SHALL print an error indicating it cannot connect and exit with code 1

#### Scenario: Custom port
- **WHEN** a developer runs `lws status --port 4000`
- **THEN** the command SHALL query the management API on port 4000 instead of the default

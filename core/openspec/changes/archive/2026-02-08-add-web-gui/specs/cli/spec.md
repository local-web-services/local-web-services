## ADDED Requirements
### Requirement: Web GUI Dashboard
The management API SHALL serve a web-based dashboard at `GET /_ldk/gui` as a self-contained HTML page with inline CSS and JavaScript. The dashboard SHALL provide three capabilities: a real-time log viewer, a resource explorer, and operation invocation. The dashboard SHALL require no external build step or frontend framework installation.

#### Scenario: Access dashboard in browser
- **WHEN** a developer navigates to `http://localhost:<port>/_ldk/gui` while `ldk dev` is running
- **THEN** the browser SHALL display the dashboard with log viewer, resource explorer, and operation invocation sections

#### Scenario: Dashboard works without internet
- **WHEN** a developer opens the dashboard with no internet connection
- **THEN** the dashboard SHALL function fully since all CSS and JavaScript are inlined

### Requirement: WebSocket Log Endpoint
The management API SHALL provide a WebSocket endpoint at `/_ldk/ws/logs` that streams structured log entries as JSON messages. On connection, the endpoint SHALL send any buffered recent log entries before streaming live entries. Each message SHALL be a JSON object with at minimum `timestamp`, `level`, and `message` fields.

#### Scenario: Stream logs via WebSocket
- **WHEN** a WebSocket client connects to `ws://localhost:<port>/_ldk/ws/logs`
- **THEN** the client SHALL receive buffered log entries followed by live entries as they occur

#### Scenario: Multiple clients receive same logs
- **WHEN** two WebSocket clients are connected to the log endpoint and a log entry is produced
- **THEN** both clients SHALL receive the log entry

### Requirement: GUI Live Log Viewer
The dashboard log viewer SHALL display log entries streamed via the WebSocket endpoint with color coding by log level. The viewer SHALL auto-scroll to show the latest entries and provide a pause/resume button to freeze scrolling. HTTP request logs SHALL show method, path, handler, duration, and status code. Error logs SHALL be highlighted in red.

#### Scenario: Logs auto-scroll
- **WHEN** new log entries arrive while the log viewer is active and not paused
- **THEN** the viewer SHALL scroll to show the latest entry

#### Scenario: Pause and resume log scrolling
- **WHEN** the developer clicks the pause button
- **THEN** new log entries SHALL continue to be appended but the viewer SHALL not auto-scroll until resumed

### Requirement: GUI Resource Explorer
The dashboard resource explorer SHALL display all services and their resources by fetching `GET /_ldk/resources` and `GET /_ldk/status`. Resources SHALL be grouped by service type and show the service port, resource names, and provider health status. The explorer SHALL provide a refresh button to reload the data.

#### Scenario: View all resources
- **WHEN** the developer opens the resource explorer tab
- **THEN** the dashboard SHALL display all services grouped by type with their port, health status, and resource list

#### Scenario: Refresh resource data
- **WHEN** the developer clicks the refresh button
- **THEN** the dashboard SHALL re-fetch resource and status data and update the display

### Requirement: GUI Operation Invocation
The dashboard SHALL allow developers to invoke operations on resources directly from the browser. Each resource SHALL display action buttons matching the operations available via the `lws` CLI. Clicking an action button SHALL present a form for required parameters, execute the operation against the service wire-protocol endpoint, and display the JSON result inline.

#### Scenario: Invoke DynamoDB scan from GUI
- **WHEN** the developer clicks the "Scan" action on a DynamoDB table resource
- **THEN** the dashboard SHALL send a DynamoDB Scan request to the DynamoDB service port and display the result as formatted JSON

#### Scenario: Invoke SQS send-message from GUI
- **WHEN** the developer fills in the message body and clicks "Send Message" on an SQS queue resource
- **THEN** the dashboard SHALL send a SendMessage request to the SQS service port and display the result

#### Scenario: Invoke API Gateway test from GUI
- **WHEN** the developer selects an API route, fills in optional body, and clicks "Test Invoke"
- **THEN** the dashboard SHALL send the HTTP request to the API Gateway port and display the response status, headers, and body

#### Scenario: Display invocation error
- **WHEN** an operation invocation fails
- **THEN** the dashboard SHALL display the error message in a visible error state

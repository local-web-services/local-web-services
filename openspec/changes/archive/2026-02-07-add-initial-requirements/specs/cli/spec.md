## ADDED Requirements

### Requirement: Dev Command
The CLI SHALL provide an `ldk dev` command that starts the full local development environment from a CDK project directory. The command SHALL run `cdk synth` if the cloud assembly is stale or missing, parse the cloud assembly, start local service equivalents for all discovered resources, wire event sources and triggers, configure SDK endpoint redirection, and begin watching for file changes.

#### Scenario: Start local environment from CDK project
- **WHEN** a developer runs `ldk dev` in a directory containing a valid CDK project
- **THEN** the cloud assembly is synthesized (if needed), all application resources are started locally, and the terminal displays a summary of routes, handlers, tables, queues, and other resources with their local endpoints

#### Scenario: Auto-synthesis when cloud assembly is stale
- **WHEN** a developer runs `ldk dev` and the `cdk.out` directory is missing or older than the CDK source files
- **THEN** LDK SHALL automatically run `cdk synth` before starting the local environment

#### Scenario: Graceful shutdown
- **WHEN** a developer presses Ctrl+C while `ldk dev` is running
- **THEN** all local services SHALL be gracefully shut down and state SHALL be persisted to disk

### Requirement: Invoke Command
The CLI SHALL provide an `ldk invoke` command that directly invokes any handler with a custom event payload.

#### Scenario: Invoke handler with custom event
- **WHEN** a developer runs `ldk invoke <handlerName> --event '<json>'`
- **THEN** the specified handler SHALL be invoked with the provided JSON event and the response SHALL be displayed in the terminal

### Requirement: Send Command
The CLI SHALL provide an `ldk send` command that sends a message to a named queue.

#### Scenario: Send message to queue
- **WHEN** a developer runs `ldk send <queueName> '<messageJson>'`
- **THEN** the message SHALL be enqueued in the specified local queue and any connected event source mapping SHALL process it

### Requirement: Emit Command
The CLI SHALL provide an `ldk emit` command that triggers an event on a named resource.

#### Scenario: Emit S3 event
- **WHEN** a developer runs `ldk emit <bucketName> s3:ObjectCreated --key <keyPath>`
- **THEN** the corresponding S3 event notification handler SHALL be invoked with a correctly shaped S3 event

### Requirement: Trigger Command
The CLI SHALL provide an `ldk trigger` command that immediately fires a scheduled event.

#### Scenario: Trigger scheduled handler
- **WHEN** a developer runs `ldk trigger <scheduleName>`
- **THEN** the scheduled handler SHALL be invoked immediately regardless of the cron schedule

### Requirement: Reset Command
The CLI SHALL provide an `ldk reset` command that clears all persisted local state.

#### Scenario: Reset local state
- **WHEN** a developer runs `ldk reset`
- **THEN** all persisted data in local databases, queues, and filesystem storage SHALL be deleted and the next `ldk dev` session SHALL start with a clean state

### Requirement: Stop Command
The CLI SHALL provide an `ldk stop` command that stops a background LDK session.

#### Scenario: Stop background session
- **WHEN** a developer runs `ldk stop` while an `ldk dev --background` session is running
- **THEN** the background session SHALL be gracefully shut down

### Requirement: Background Mode
The CLI SHALL support a `--background` flag on `ldk dev` that runs the local environment as a background process.

#### Scenario: Start in background for CI
- **WHEN** a developer runs `ldk dev --background --port 3000`
- **THEN** the local environment SHALL start in the background and the command SHALL return immediately after startup is complete

### Requirement: Debug Mode
The CLI SHALL support an `--inspect` flag on `ldk dev` that starts handler processes with debugger support enabled.

#### Scenario: Enable Node.js debugging
- **WHEN** a developer runs `ldk dev --inspect`
- **THEN** Node.js handler processes SHALL start with the Node.js inspector enabled, allowing IDE debugger attachment

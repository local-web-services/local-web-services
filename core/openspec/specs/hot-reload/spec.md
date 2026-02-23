# hot-reload Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Application Code Hot Reload
LDK SHALL watch application source files (using watchdog) and hot-reload affected handlers when changes are detected, without restarting the entire environment.

#### Scenario: Handler code change reloaded
- **WHEN** a developer saves a change to a Lambda handler file
- **THEN** the handler module SHALL be reloaded and the next invocation SHALL use the updated code, with reload completing in under 200ms

### Requirement: Scoped Reload
Hot reload SHALL be scoped to only the affected handlers. Changing one handler SHALL NOT reload other handlers. Changing a shared module SHALL reload all handlers that import it.

#### Scenario: Single handler reload
- **WHEN** a developer changes handler A but not handler B
- **THEN** only handler A SHALL be reloaded; handler B SHALL continue using its current code

#### Scenario: Shared module reload
- **WHEN** a developer changes a shared utility module imported by handlers A and B
- **THEN** both handlers A and B SHALL be reloaded

### Requirement: CDK Source Change Detection
LDK SHALL watch CDK source files for changes, automatically re-run `cdk synth`, and apply incremental infrastructure changes without restarting the entire environment.

#### Scenario: New route added to CDK
- **WHEN** a developer adds a new API route in the CDK code and saves
- **THEN** LDK SHALL re-synthesize, detect the new route, add it to the local HTTP server, and display the change in the terminal without restarting existing services

#### Scenario: Infrastructure diff display
- **WHEN** CDK source changes result in infrastructure differences
- **THEN** the terminal SHALL display a diff showing added, removed, and modified resources before applying the changes

### Requirement: Watch Path Configuration
The file watcher SHALL support configurable include and exclude patterns for watch paths via the configuration file.

#### Scenario: Exclude test files from watching
- **WHEN** the configuration excludes `**/*.test.*` from watching
- **THEN** changes to test files SHALL NOT trigger hot reload

### Requirement: ECS Service Graceful Restart
For long-running ECS-style services, code changes SHALL trigger a graceful restart (SIGTERM, wait, SIGKILL) rather than a module reload.

#### Scenario: ECS service restarted on code change
- **WHEN** a developer changes the source code of an ECS service
- **THEN** the service process SHALL be gracefully restarted with the updated code


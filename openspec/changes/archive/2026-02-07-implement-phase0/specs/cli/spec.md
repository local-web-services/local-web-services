## MODIFIED Requirements
### Requirement: Dev Command
The CLI SHALL provide an `ldk dev` command that starts the full local development environment from a CDK project directory. The command SHALL be built with Typer and use `asyncio.run()` for the event loop. The command SHALL run `cdk synth` if the cloud assembly is stale or missing, parse the cloud assembly, start local service equivalents for all discovered resources, wire event sources and triggers, configure SDK endpoint redirection, and begin watching for file changes.

#### Scenario: Start local environment from CDK project
- **WHEN** a developer runs `ldk dev` in a directory containing a valid CDK project
- **THEN** the cloud assembly is synthesized (if needed), all application resources are started locally, and the terminal displays a summary of routes, handlers, tables, queues, and other resources with their local endpoints

#### Scenario: Auto-synthesis when cloud assembly is stale
- **WHEN** a developer runs `ldk dev` and the `cdk.out` directory is missing or older than the CDK source files
- **THEN** LDK SHALL automatically run `cdk synth` before starting the local environment

#### Scenario: Graceful shutdown
- **WHEN** a developer presses Ctrl+C while `ldk dev` is running
- **THEN** all local services SHALL be gracefully shut down and state SHALL be persisted to disk

#### Scenario: Typer CLI framework
- **WHEN** the `ldk` CLI is invoked
- **THEN** the command SHALL be dispatched via Typer with the entry point `ldk.cli.main:app` and the async orchestration SHALL run inside `asyncio.run()`

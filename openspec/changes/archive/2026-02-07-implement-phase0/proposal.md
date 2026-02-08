# Change: Implement Phase 0 Proof of Concept

## Why
LDK is a greenfield project with specifications but no implementation code. Phase 0 delivers the minimum viable product: a working `ldk dev` command that can parse a CDK cloud assembly, start local providers for API Gateway, Lambda (Node.js), and DynamoDB, wire them together via SDK endpoint redirection, and support basic hot reload -- proving the core architecture end-to-end.

## What Changes
- Scaffold the Python project with `pyproject.toml`, `uv`, and `src/ldk/` package structure
- Implement cloud assembly parsing: `tree.json`, CloudFormation templates, intrinsic function resolution, asset location, and multi-stack assembly orchestration
- Define all provider interfaces: `ICompute`, `IKeyValueStore`, `IQueue`, `IObjectStore`, `IEventBus`, `IStateMachine` with lifecycle management
- Implement configuration loading from `ldk.config.py` via `importlib`
- Implement SDK endpoint redirection environment variable builder
- Implement Node.js Lambda runtime provider (`ICompute`)
- Implement SQLite-backed DynamoDB provider (`IKeyValueStore`) with CRUD, Query, Scan, GSI support, and DynamoDB wire protocol HTTP server
- Implement API Gateway provider as a FastAPI HTTP server with request/response transformation
- Build the application graph with dependency-ordered startup
- Build the orchestrator for provider lifecycle management
- Implement CDK synth staleness detection and auto-synthesis
- Implement file watching with watchdog for hot reload
- Wire everything into the `ldk dev` Typer CLI command
- Create end-to-end integration test suite

## Impact
- Affected specs: cli, cloud-assembly-parsing, application-graph, provider-interfaces, sdk-redirection, lambda-runtime, api-gateway-provider, dynamodb-provider, hot-reload, configuration
- Affected code: All new code under `src/ldk/` -- this is the initial implementation of the entire project
- No breaking changes (greenfield project)

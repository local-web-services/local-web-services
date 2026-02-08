# Phase 0: Proof of Concept -- Implementation Tasks

## Phase 0.1: Cloud Assembly Parser

- [x] P0-01: Project Scaffolding and Package Structure
  - Set up Python project with `pyproject.toml`, `uv` for dependency management, and initial package structure
  - Create top-level `ldk` package and sub-packages: `ldk.parser`, `ldk.graph`, `ldk.interfaces`, `ldk.providers`, `ldk.runtime`, `ldk.cli`, `ldk.config`
  - Configure pytest and dev dependencies (FastAPI, Typer, watchdog, aiosqlite, croniter)
  - Use `src/` layout, configure `[project.scripts]` with `ldk = "ldk.cli.main:app"` for Typer entry point

- [x] P0-02: tree.json Parser
  - Implement parser that reads `tree.json` from CDK cloud assembly and extracts construct nodes
  - Produce `ConstructNode` dataclasses with `path`, `id`, `fqn`, `children`, `cfn_type`
  - Use `json.load()` to parse, walk `tree.children` recursively
  - Map known FQNs to resource categories
  - Unit tests: simple tree, nested constructs, missing constructInfo, multi-stack trees

- [x] P0-03: CloudFormation Template Parser
  - Implement parser for CloudFormation template JSON extracting resource definitions
  - Focus on: `AWS::Lambda::Function`, `AWS::DynamoDB::Table`, `AWS::ApiGateway::*`, `AWS::ApiGatewayV2::*`
  - Create `CfnResource` dataclass and typed property dataclasses: `LambdaFunctionProps`, `DynamoTableProps`, `ApiGatewayRouteProps`
  - Unit tests for each resource type extraction

- [x] P0-04: Intrinsic Function and Reference Resolution
  - Implement resolution of `Ref`, `Fn::GetAtt`, `Fn::Sub`, `Fn::Join`, `Fn::Select`, `Fn::If`
  - Build `RefResolver` class using visitor pattern to walk JSON tree
  - Generate deterministic local ARNs: `arn:ldk:<service>:local:000000000000:<resource-type>/<logical-id>`
  - Handle nested intrinsics recursively; unresolvable references produce warnings not crashes
  - Unit tests for each intrinsic function and nested combinations

- [x] P0-05: Asset Manifest Parser and Asset Locator
  - Parse `manifest.json` and asset manifest files from `cdk.out`
  - Map asset hashes to filesystem paths within `cdk.out/asset.<hash>/`
  - Return `AssetMap` dict mapping asset hashes to absolute paths
  - Unit tests: single asset, multiple assets, missing asset directory

- [x] P0-06: Assembly Orchestrator and Normalized Resource Model
  - Create top-level `parse_assembly(cdk_out_path)` that ties together tree parsing, template parsing, reference resolution, and asset location
  - Produce `AppModel` containing typed resource descriptors: `LambdaFunction`, `DynamoTable`, `ApiDefinition`, `ApiRoute`
  - Handle multi-stack assemblies with cross-stack reference resolution via CloudFormation exports/imports
  - Integration test with realistic `cdk.out` fixture

## Phase 0.2: Provider Interface Definition

- [x] P0-07: Provider Lifecycle and Base Interface
  - Define `Provider` ABC with `async start()`, `async stop()`, `async health_check() -> bool`
  - Define `ProviderStatus` enum: `STOPPED`, `STARTING`, `RUNNING`, `ERROR`
  - Define `ProviderError` exception hierarchy
  - Keep `ldk.interfaces` free of dependencies on other `ldk` sub-packages

- [x] P0-08: ICompute Interface
  - Define `ICompute` ABC extending `Provider` with `async invoke(event, context) -> InvocationResult`
  - Define `LambdaContext` dataclass with `function_name`, `memory_limit_in_mb`, `timeout_seconds`, `aws_request_id`, `get_remaining_time_in_millis()`
  - Define `InvocationResult` dataclass with `payload`, `error`, `duration_ms`, `request_id`
  - Define `ComputeConfig` dataclass

- [x] P0-09: IKeyValueStore Interface
  - Define `IKeyValueStore` ABC extending `Provider` with CRUD, query, scan, batch methods
  - Define `KeySchema`, `TableConfig`, `GsiDefinition` dataclasses
  - Method signatures use generic dict-based items

- [x] P0-10: Remaining Provider Interfaces (IQueue, IObjectStore, IEventBus, IStateMachine)
  - Define stub interfaces with method signatures for future phases
  - All interfaces extend `Provider` base
  - Re-export all interfaces from `ldk.interfaces.__init__`

## Phase 0.3: Minimal Local Runtime

- [x] P0-11: Configuration Module
  - Implement `load_config(project_dir) -> LdkConfig` that reads `ldk.config.py` via `importlib`
  - `LdkConfig` dataclass with defaults: port=3000, persist=True, data_dir=".ldk", log_level="info"
  - Sensible defaults when no config file present; `ConfigError` for invalid values
  - Unit tests: no config, valid config, partial config, invalid values

- [x] P0-12: SDK Endpoint Redirection Environment Builder
  - Build `build_sdk_env(endpoints) -> dict[str, str]` generating AWS SDK endpoint env vars
  - Set `AWS_ENDPOINT_URL_DYNAMODB`, `AWS_ENDPOINT_URL_SQS`, `AWS_ENDPOINT_URL_S3` etc.
  - Set dummy credentials: `AWS_ACCESS_KEY_ID=ldk-local`, `AWS_SECRET_ACCESS_KEY=ldk-local`
  - Unit tests for env var generation

- [x] P0-13: Node.js Lambda Runtime Provider (ICompute Implementation)
  - Implement `NodeJsCompute` provider for `nodejs18.x`, `nodejs20.x`, `nodejs22.x` runtimes
  - Create Node.js invoker script that loads handler module, calls function, returns result via stdout
  - Use `asyncio.create_subprocess_exec` to run `node invoker.js`
  - Enforce timeout via `asyncio.wait_for` with `process.kill()`
  - Merge CDK env vars and SDK redirection env vars into subprocess environment
  - Integration test with real simple Node.js handler

- [x] P0-14: SQLite DynamoDB Provider -- Table Setup and Basic CRUD
  - Implement `IKeyValueStore` with SQLite backend via aiosqlite
  - Schema: `CREATE TABLE <name> (pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))`
  - Implement `put_item`, `get_item`, `delete_item`, `update_item` (SET and REMOVE)
  - Data persists across stop/start via SQLite file on disk
  - Unit tests: create table, put+get, put+delete, update SET, update REMOVE, persistence

- [x] P0-15: SQLite DynamoDB Provider -- Query and Scan Operations
  - Implement `query` with key condition expressions (=, <, >, <=, >=, begins_with, BETWEEN)
  - Implement `scan` with filter expressions
  - Add GSI support: additional SQLite tables per GSI, automatic GSI maintenance on put/delete
  - Filter expression evaluation in Python post-fetch
  - Unit tests: query by PK, query by PK+SK range, scan, scan with filter, GSI query

- [x] P0-16: DynamoDB Wire Protocol HTTP Server
  - FastAPI app that speaks DynamoDB wire protocol via `X-Amz-Target` header routing
  - Support operations: GetItem, PutItem, DeleteItem, UpdateItem, Query, Scan, BatchGetItem, BatchWriteItem
  - Parse DynamoDB JSON request format, dispatch to `IKeyValueStore`, serialize responses
  - Integration test using boto3 against running server

- [x] P0-17: API Gateway Provider (FastAPI HTTP Server)
  - Create FastAPI app mapping CDK-defined routes to Lambda handler invocations
  - Transform HTTP requests to API Gateway V1 proxy integration events
  - Transform handler responses back to HTTP responses
  - Extract path parameters, query strings, headers correctly
  - Integration test: start server, send HTTP request, verify round-trip

- [x] P0-18: Lambda Environment Variable Resolution and Injection
  - Build `build_lambda_env(function, local_endpoints, resolved_refs) -> dict[str, str]`
  - Resolve remaining `Ref` and `Fn::GetAtt` values to local resource names/ARNs
  - Merge SDK redirection env vars
  - Integration test with Lambda referencing table via Ref

## Phase 0.4: `ldk dev` Command

- [x] P0-19: Application Graph Builder
  - Build `build_graph(app_model) -> AppGraph` with nodes and directed edges
  - Edge types: `TRIGGER` (API->Lambda), `DATA_DEPENDENCY` (Lambda->DynamoDB)
  - Topological sort via Kahn's algorithm for startup ordering
  - Circular dependency detection
  - Unit tests: API->Lambda->DynamoDB chain, multiple routes, startup ordering

- [x] P0-20: Orchestrator -- Provider Lifecycle Manager
  - Build `Orchestrator` with `async start(app_graph, config)` and `async stop()`
  - Start providers in topological order: tables first, then functions, then API routes
  - Health check after each provider start; reverse-order shutdown
  - SIGINT/SIGTERM handlers for graceful shutdown
  - Logging of startup progress
  - Integration test: start/stop with simple app graph

- [x] P0-21: CDK Synth Runner
  - Build `ensure_synth(project_dir, force)` that checks staleness and runs `cdk synth`
  - Staleness: compare `cdk.out/manifest.json` mtime against source files
  - Stream synth output to terminal in real-time
  - `SynthError` on non-zero exit
  - Unit tests: staleness detection, synth invocation (mocked)

- [x] P0-22: File Watcher with watchdog
  - Implement `FileWatcher` using watchdog `Observer` and custom `FileSystemEventHandler`
  - Notify compute provider to invalidate module cache on handler code changes
  - Respect include/exclude patterns from config
  - Debounce rapid changes (300ms window)
  - Print notification on CDK source changes
  - Unit tests: file change detection, debouncing, exclude patterns

- [x] P0-23: Terminal Output and Status Display
  - Startup banner with LDK version and project name
  - Resource summary table: API routes, DynamoDB tables, Lambda functions
  - Invocation log formatting: `[HH:MM:SS] POST /orders -> createOrder (152ms, 200)`
  - Error display with Rich formatting
  - Unit tests for output formatting functions

- [x] P0-24: `ldk dev` CLI Command -- Full Wiring
  - Typer command with options: `--port`, `--no-persist`, `--force-synth`, `--log-level`
  - Flow: load_config -> ensure_synth -> parse_assembly -> build_graph -> orchestrator.start -> watcher.start -> display -> event loop
  - CLI arg precedence over config file; graceful Ctrl+C shutdown
  - End-to-end test: `ldk dev` starts and API Gateway responds through Lambda to DynamoDB

- [x] P0-25: End-to-End Integration Test Suite
  - Test fixture: `tests/fixtures/sample-app/` with pre-synthesized `cdk.out/`
  - E2E test: HTTP POST to create item, HTTP GET to read it back
  - Verify DynamoDB writes, environment variable injection, graceful shutdown
  - All tests pass in CI (Node.js required for Lambda handler)

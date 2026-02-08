# LDK Implementation Tasks

## Summary

| Phase | Focus | Tasks | Duration |
|-------|-------|-------|----------|
| Phase 0 | Proof of Concept | ~25 tasks | ~27 days |
| Phase 1 | Core Runtime | ~40 tasks | ~54 days |
| Phase 2 | Advanced Constructs | ~34 tasks | ~47 days |
| **Total** | | **~99 tasks** | **~128 days** |

---

# Phase 0: Proof of Concept -- Implementation Tasks

## Phase 0.1: Cloud Assembly Parser

### Task P0-01: Project Scaffolding and Package Structure
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: provider-interfaces (Interface Package Independence), configuration (Configuration File)
**Depends on**: None

**Description**: Set up the Python project with `pyproject.toml`, `uv` for dependency management, and the initial package structure. Create the top-level `ldk` package and sub-packages: `ldk.parser`, `ldk.graph`, `ldk.interfaces`, `ldk.providers`, `ldk.runtime`, `ldk.cli`, and `ldk.config`. Configure pytest and basic dev dependencies (FastAPI, Typer, watchdog, aiosqlite, croniter).

**Acceptance Criteria**:
- [ ] `pyproject.toml` exists with all Phase 0 dependencies declared (fastapi, typer, watchdog, aiosqlite, croniter, uvicorn, pytest, pytest-asyncio)
- [ ] `uv sync` installs all dependencies successfully
- [ ] `uv run pytest` executes and passes (with at least one trivial test)
- [ ] Package structure exists: `src/ldk/__init__.py`, `src/ldk/parser/`, `src/ldk/graph/`, `src/ldk/interfaces/`, `src/ldk/providers/`, `src/ldk/runtime/`, `src/ldk/cli/`, `src/ldk/config/`
- [ ] `ldk` is installable as a CLI entry point via `pyproject.toml` `[project.scripts]`

**Technical Approach**:
- Use `uv init` or manually create `pyproject.toml` with `[build-system]` using hatchling or setuptools
- Use `src/` layout for clean package isolation
- Configure `[project.scripts]` with `ldk = "ldk.cli.main:app"` for Typer entry point
- Add `conftest.py` at project root with shared fixtures for `cdk.out` test data

---

### Task P0-02: tree.json Parser
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cloud-assembly-parsing (Tree JSON Parsing)
**Depends on**: P0-01

**Description**: Implement a parser that reads `tree.json` from a CDK cloud assembly directory and extracts construct nodes with their `constructInfo.fqn` types and parent-child hierarchy. The parser should produce a flat list of construct nodes with their paths, types, and children references.

**Acceptance Criteria**:
- [ ] `ldk.parser.tree` module parses a valid `tree.json` and returns a dict of construct nodes keyed by construct path
- [ ] Each node contains: `path`, `id`, `fqn` (from `constructInfo.fqn`), `children` (list of child paths), and `cfn_type` (if it maps to a CloudFormation resource)
- [ ] Lambda functions, DynamoDB tables, API Gateway resources, SQS queues are correctly identified by their FQN
- [ ] Parser raises a clear `ParseError` if `tree.json` is missing or malformed
- [ ] Unit tests cover: simple tree, nested constructs, missing `constructInfo`, and multi-stack trees

**Technical Approach**:
- Read `tree.json` with `json.load()`, walk the `tree.children` recursively
- Create a `ConstructNode` dataclass with `path`, `id`, `fqn`, `children`, `cfn_type`
- Map known FQNs to resource categories (e.g., `aws-cdk-lib.aws_lambda.Function` -> `LAMBDA_FUNCTION`)
- Create test fixtures in `tests/fixtures/` with sample `tree.json` files from real CDK projects

---

### Task P0-03: CloudFormation Template Parser
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cloud-assembly-parsing (CloudFormation Template Parsing)
**Depends on**: P0-01

**Description**: Implement a parser that reads CloudFormation templates (JSON) from the cloud assembly and extracts resource definitions with their properties. Focus on the resource types needed for Phase 0: `AWS::Lambda::Function`, `AWS::DynamoDB::Table`, `AWS::ApiGateway::RestApi`, `AWS::ApiGateway::Resource`, `AWS::ApiGateway::Method`, `AWS::ApiGatewayV2::Api`, `AWS::ApiGatewayV2::Route`, and `AWS::ApiGatewayV2::Integration`.

**Acceptance Criteria**:
- [ ] `ldk.parser.cfn_template` module parses a CloudFormation template JSON and returns a dict of `CfnResource` objects keyed by logical ID
- [ ] Lambda function resources extract: handler path, runtime, timeout, memory, environment variables, code URI/asset reference
- [ ] DynamoDB table resources extract: table name, key schema (partition + sort key), attribute definitions, GSI definitions, stream specification
- [ ] API Gateway resources extract: route path, HTTP method, integration target (Lambda logical ID)
- [ ] Unit tests cover extraction of each resource type with realistic CloudFormation snippets

**Technical Approach**:
- Create `CfnResource` dataclass with `logical_id`, `cfn_type`, `properties` (raw dict), and typed accessor methods per resource type
- Create typed dataclasses: `LambdaFunctionProps`, `DynamoTableProps`, `ApiGatewayRouteProps`
- Parse both REST API (v1) and HTTP API (v2) resource shapes
- Handle CDK-generated logical IDs (hashed suffixes)

---

### Task P0-04: Intrinsic Function and Reference Resolution
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cloud-assembly-parsing (Reference Resolution)
**Depends on**: P0-03

**Description**: Implement resolution of CloudFormation intrinsic functions (`Ref`, `Fn::GetAtt`, `Fn::Sub`, `Fn::Join`, `Fn::Select`, `Fn::If`) within a single template. Build a resolver that replaces references with local placeholder values (e.g., table names resolve to the local table identifier). This enables environment variable resolution for Lambda functions.

**Acceptance Criteria**:
- [ ] `ldk.parser.resolver` module resolves `Ref` to a resource by logical ID, returning a local-meaningful value (logical ID as fallback, table name for DynamoDB, etc.)
- [ ] `Fn::GetAtt` resolves to a resource attribute placeholder (e.g., `{"Fn::GetAtt": ["MyTable", "Arn"]}` -> `"arn:ldk:dynamodb:local:000000000000:table/MyTable"`)
- [ ] `Fn::Sub` resolves variable references within template strings
- [ ] `Fn::Join` concatenates arrays with a delimiter
- [ ] Nested intrinsics are resolved recursively (e.g., `Fn::Join` containing `Ref` elements)
- [ ] Unresolvable references produce a descriptive warning and a placeholder string rather than crashing
- [ ] Unit tests cover each intrinsic function and nested combinations

**Technical Approach**:
- Build a `RefResolver` class that takes the full resource map and resolves references by walking the JSON tree
- Use a visitor pattern: recursively walk dicts/lists, detect intrinsic function keys, resolve them
- Generate deterministic local ARNs using `arn:ldk:<service>:local:000000000000:<resource-type>/<logical-id>` format
- For `Ref` on different resource types, return the appropriate "physical" local name (table name, queue URL, etc.)

---

### Task P0-05: Asset Manifest Parser and Asset Locator
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cloud-assembly-parsing (Asset Location)
**Depends on**: P0-01

**Description**: Implement parsing of the CDK asset manifest to locate Lambda code assets on disk. Read the `manifest.json` and asset manifest files from `cdk.out` to map asset IDs to their filesystem paths, enabling the runtime to find handler code directories.

**Acceptance Criteria**:
- [ ] `ldk.parser.assets` module reads `manifest.json` (cloud assembly manifest) and identifies all stacks and their template file paths
- [ ] For each Lambda function referencing an `S3Bucket`/`S3Key` code property, the asset hash is resolved to a directory path within `cdk.out/asset.<hash>/`
- [ ] The module returns an `AssetMap` dict mapping asset hashes to absolute filesystem paths
- [ ] Works with both bundled assets (esbuild output) and non-bundled (raw source) assets
- [ ] Unit tests cover: single asset, multiple assets, missing asset directory raises clear error

**Technical Approach**:
- Parse `manifest.json` to find artifact entries of type `aws:cloudformation:stack`
- Parse the asset manifest file (e.g., `cdk.out/<stack>.assets.json`) for file asset entries
- Each file asset has an `id` (hash) and `source.path` -- resolve relative to `cdk.out` directory
- Return `dict[str, Path]` mapping asset hashes to absolute paths
- Cross-reference Lambda function `Code.S3Key` property to find the matching asset hash

---

### Task P0-06: Assembly Orchestrator and Normalized Resource Model
**Sprint**: Phase 0 - 0.1 (Cloud Assembly Parser)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cloud-assembly-parsing (Multi-Stack Support, Language Agnostic Parsing), application-graph (Graph Construction)
**Depends on**: P0-02, P0-03, P0-04, P0-05

**Description**: Create the top-level orchestrator that ties together tree parsing, template parsing, reference resolution, and asset location into a single `parse_assembly(cdk_out_path)` function. Produce a normalized `AppModel` containing typed resource descriptors (`LambdaFunction`, `DynamoTable`, `ApiRoute`, etc.) with all references resolved and assets located. Handle multi-stack assemblies by merging resources and resolving cross-stack references via CloudFormation exports/imports.

**Acceptance Criteria**:
- [ ] `ldk.parser.assembly` module exposes `parse_assembly(cdk_out_dir: Path) -> AppModel`
- [ ] `AppModel` contains: `functions: dict[str, LambdaFunction]`, `tables: dict[str, DynamoTable]`, `apis: dict[str, ApiDefinition]`, and `routes: list[ApiRoute]`
- [ ] Each `LambdaFunction` has resolved: `handler`, `runtime`, `timeout`, `memory`, `environment` (with refs resolved), `code_path` (absolute path to asset dir)
- [ ] Each `DynamoTable` has resolved: `table_name`, `key_schema`, `gsi_definitions`
- [ ] Each `ApiRoute` has resolved: `path`, `method`, `handler_logical_id` (linked to a `LambdaFunction`)
- [ ] Multi-stack: cross-stack `Fn::ImportValue` references are resolved against matching `Export` outputs
- [ ] Integration test parses a realistic `cdk.out` fixture and produces a correct `AppModel`

**Technical Approach**:
- Create `AppModel`, `LambdaFunction`, `DynamoTable`, `ApiDefinition`, `ApiRoute` dataclasses in `ldk.parser.models`
- Walk all stacks in manifest order, parse each template, merge resources into unified maps
- Resolve cross-stack refs: first pass collects all `Outputs` with `Export.Name`, second pass resolves `Fn::ImportValue`
- Final pass: transform raw `CfnResource` objects into typed model objects using resource-type-specific extractors
- Create a comprehensive `cdk.out` test fixture directory in `tests/fixtures/sample-app/cdk.out/`

---

## Phase 0.2: Provider Interface Definition

### Task P0-07: Provider Lifecycle and Base Interface
**Sprint**: Phase 0 - 0.2 (Provider Interface Definition)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: provider-interfaces (Provider Lifecycle, Interface Package Independence)
**Depends on**: P0-01

**Description**: Define the base `Provider` abstract class with lifecycle methods (`start`, `stop`, `health_check`) and the configuration plumbing that all provider interfaces inherit from. This establishes the pattern for all providers.

**Acceptance Criteria**:
- [ ] `ldk.interfaces.base` module defines `Provider` ABC with abstract methods: `async start()`, `async stop()`, `async health_check() -> bool`
- [ ] `Provider` has a `name: str` property and accepts a config dict in its constructor
- [ ] `ProviderStatus` enum defined: `STOPPED`, `STARTING`, `RUNNING`, `ERROR`
- [ ] Base class tracks status transitions and exposes `status` property
- [ ] Unit test verifies that a concrete subclass must implement all abstract methods

**Technical Approach**:
- Use Python `abc.ABC` and `abc.abstractmethod`
- Use `dataclasses` or `pydantic.BaseModel` for config objects
- Keep `ldk.interfaces` free of dependencies on other `ldk` sub-packages (per spec requirement)
- Define `ProviderError` exception hierarchy: `ProviderStartError`, `ProviderInvokeError`

---

### Task P0-08: ICompute Interface
**Sprint**: Phase 0 - 0.2 (Provider Interface Definition)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: provider-interfaces (Compute Interface), lambda-runtime (Node.js Handler Execution, Lambda Context Object, Timeout Enforcement, Environment Variable Injection)
**Depends on**: P0-07

**Description**: Define the `ICompute` interface (abstract class) that represents a Lambda-like compute provider. It should accept handler configuration (runtime, handler path, environment, timeout) and expose an `invoke(event, context)` method.

**Acceptance Criteria**:
- [ ] `ldk.interfaces.compute` module defines `ICompute` ABC extending `Provider`
- [ ] `ICompute` defines: `async invoke(event: dict, context: LambdaContext) -> InvocationResult`
- [ ] `LambdaContext` dataclass defined with: `function_name`, `memory_limit_in_mb`, `timeout_seconds`, `aws_request_id`, `get_remaining_time_in_millis()` method
- [ ] `InvocationResult` dataclass defined with: `payload`, `error`, `duration_ms`, `request_id`
- [ ] `ComputeConfig` dataclass defined with: `runtime`, `handler`, `code_path`, `environment`, `timeout_seconds`, `memory_mb`
- [ ] Unit test verifies interface contract (cannot instantiate ABC directly)

**Technical Approach**:
- `LambdaContext` should track invocation start time to compute `get_remaining_time_in_millis()`
- `InvocationResult.error` should be an optional typed object with `errorType`, `errorMessage`, `trace`
- Keep runtime-specific details (Node.js vs Python) out of the interface -- those go in the provider implementation

---

### Task P0-09: IKeyValueStore Interface
**Sprint**: Phase 0 - 0.2 (Provider Interface Definition)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: provider-interfaces (Key-Value Store Interface), dynamodb-provider (Table Creation, Basic CRUD Operations, Query Operations, Scan Operations)
**Depends on**: P0-07

**Description**: Define the `IKeyValueStore` interface that represents a DynamoDB-like key-value store. Include methods for CRUD operations, query, scan, and batch operations parameterized by key schema.

**Acceptance Criteria**:
- [ ] `ldk.interfaces.key_value_store` module defines `IKeyValueStore` ABC extending `Provider`
- [ ] Methods defined: `async get_item(key)`, `async put_item(item)`, `async delete_item(key)`, `async update_item(key, update_expr)`, `async query(key_condition)`, `async scan(filter_expr)`, `async batch_get(keys)`, `async batch_write(items)`
- [ ] `KeySchema` dataclass defined with: `partition_key` (name, type), optional `sort_key` (name, type)
- [ ] `TableConfig` dataclass defined with: `table_name`, `key_schema`, `gsi_definitions`, `stream_enabled`
- [ ] `GsiDefinition` dataclass defined with: `index_name`, `key_schema`, `projection_type`, `non_key_attributes`
- [ ] Unit test verifies interface cannot be instantiated and requires all methods

**Technical Approach**:
- Method signatures should use generic dict-based items (`dict[str, Any]`) rather than DynamoDB wire format -- the provider translates
- Query and scan should accept string expressions and expression attribute values/names (matching DynamoDB API shape for SDK compatibility)
- Include type aliases: `Key = dict[str, Any]`, `Item = dict[str, Any]`

---

### Task P0-10: Remaining Provider Interfaces (IQueue, IObjectStore, IEventBus, IStateMachine)
**Sprint**: Phase 0 - 0.2 (Provider Interface Definition)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: provider-interfaces (Queue Interface, Object Store Interface, Event Bus Interface, State Machine Interface)
**Depends on**: P0-07

**Description**: Define the remaining provider interfaces needed for future phases. While these won't be implemented in Phase 0, defining them now ensures the architecture is sound and future providers can be developed independently. These are stub interfaces with method signatures but no implementation.

**Acceptance Criteria**:
- [ ] `ldk.interfaces.queue` defines `IQueue` ABC with: `send`, `receive`, `delete`, `dead_letter`; `QueueConfig` with `fifo`, `visibility_timeout`, `dlq_config`
- [ ] `ldk.interfaces.object_store` defines `IObjectStore` ABC with: `put`, `get`, `delete`, `list_objects`; `ObjectStoreConfig` with `bucket_name`, `event_notifications`
- [ ] `ldk.interfaces.event_bus` defines `IEventBus` ABC with: `publish`, `subscribe`, `match_rules`; `EventBusConfig` with `bus_name`, `rules`
- [ ] `ldk.interfaces.state_machine` defines `IStateMachine` ABC with: `start_execution`, `get_execution_status`; `StateMachineConfig` with `definition`, `name`
- [ ] All interfaces extend `Provider` base and inherit lifecycle methods
- [ ] `ldk.interfaces.__init__` re-exports all interfaces for clean import

**Technical Approach**:
- Follow the same patterns established in P0-08 and P0-09
- Keep method signatures minimal but correct -- they can be expanded when implemented
- Add docstrings referencing the spec requirements for each method
- Create an `__init__.py` that exports: `Provider`, `ICompute`, `IKeyValueStore`, `IQueue`, `IObjectStore`, `IEventBus`, `IStateMachine`

---

## Phase 0.3: Minimal Local Runtime

### Task P0-11: Configuration Module
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: configuration (Configuration File, Port Configuration, State Persistence Configuration, Watch Path Configuration)
**Depends on**: P0-01

**Description**: Implement the configuration loading system that reads `ldk.config.py` from the project root and merges it with sensible defaults. Support the core Phase 0 settings: port, data directory, persistence toggle, log level, and watch path patterns.

**Acceptance Criteria**:
- [ ] `ldk.config.loader` module exposes `load_config(project_dir: Path) -> LdkConfig`
- [ ] `LdkConfig` dataclass with fields: `port` (default: 3000), `persist` (default: True), `data_dir` (default: `.ldk`), `log_level` (default: `"info"`), `watch_include` (default: `["src/**", "lib/**", "lambda/**"]`), `watch_exclude` (default: `["**/node_modules/**", "**/*.test.*", "**/cdk.out/**"]`)
- [ ] If `ldk.config.py` exists, it is loaded via `importlib` and its module-level variables override defaults
- [ ] If `ldk.config.py` does not exist, defaults are used without error
- [ ] Invalid configuration values raise `ConfigError` with a clear message
- [ ] Unit tests cover: no config file, valid config file, partial config file, invalid values

**Technical Approach**:
- Use `importlib.util.spec_from_file_location` and `module_from_spec` to load the Python config file
- Extract known attribute names from the loaded module and map to `LdkConfig` fields
- Validate types and ranges (e.g., port must be 1-65535)
- Store resolved `data_dir` as an absolute path relative to project root

---

### Task P0-12: SDK Endpoint Redirection Environment Builder
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: sdk-redirection (Endpoint URL Configuration, Transparent Redirection, Multi-SDK Compatibility)
**Depends on**: P0-11

**Description**: Build a module that generates the environment variables needed for AWS SDK endpoint redirection. Given the local endpoints (DynamoDB port, API Gateway port, etc.), produce a dict of environment variables (`AWS_ENDPOINT_URL`, `AWS_ENDPOINT_URL_DYNAMODB`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, etc.) that cause AWS SDKs to route requests to local providers.

**Acceptance Criteria**:
- [ ] `ldk.runtime.sdk_env` module exposes `build_sdk_env(endpoints: dict[str, str]) -> dict[str, str]`
- [ ] Output includes `AWS_ENDPOINT_URL_DYNAMODB`, `AWS_ENDPOINT_URL_SQS`, `AWS_ENDPOINT_URL_S3` set to local URLs
- [ ] Output includes `AWS_ACCESS_KEY_ID = "ldk-local"`, `AWS_SECRET_ACCESS_KEY = "ldk-local"`, `AWS_DEFAULT_REGION = "us-east-1"`
- [ ] Service-specific endpoint URLs use the format `http://localhost:<port>`
- [ ] Unit tests verify correct env var generation for DynamoDB, SQS, and S3 endpoints

**Technical Approach**:
- Service name to env var mapping: `{"dynamodb": "AWS_ENDPOINT_URL_DYNAMODB", "sqs": "AWS_ENDPOINT_URL_SQS", ...}`
- Also set `AWS_ENDPOINT_URL` as a catch-all for services without specific vars (newer SDK behavior)
- Set dummy credentials since local providers don't need real auth but SDKs require them to be present

---

### Task P0-13: Node.js Lambda Runtime Provider (ICompute Implementation)
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 2 days | **Points**: 4/5
**Specs**: lambda-runtime (Node.js Handler Execution, Lambda Context Object, Timeout Enforcement, Environment Variable Injection), provider-interfaces (Compute Interface)
**Depends on**: P0-08, P0-12

**Description**: Implement the `NodeJsCompute` provider that executes Node.js Lambda handlers. It should spawn a Node.js subprocess (or use a persistent worker process) that loads the handler module, invokes it with the event and context, and returns the result. Support timeout enforcement and environment variable injection including SDK redirection vars.

**Acceptance Criteria**:
- [ ] `ldk.providers.nodejs_compute` implements `ICompute` for `runtime: "nodejs18.x" | "nodejs20.x" | "nodejs22.x"`
- [ ] Handler invocation: given `handler = "index.handler"` and `code_path`, correctly loads `index.js` and calls the `handler` export
- [ ] Lambda context object provided to handler includes: `functionName`, `memoryLimitInMB`, `awsRequestId` (UUID), `getRemainingTimeInMillis()` returning accurate countdown
- [ ] Timeout enforcement: handler killed after configured timeout, returns timeout error
- [ ] Environment variables from CDK config AND SDK redirection vars are merged and set in subprocess environment
- [ ] Handler errors (thrown exceptions) are caught and returned as `InvocationResult.error` with stack trace
- [ ] Integration test invokes a real simple Node.js handler (e.g., `async (event) => ({ statusCode: 200, body: JSON.stringify(event) })`)

**Technical Approach**:
- Create a Node.js "invoker" script (`src/ldk/runtime/invoker.js`) that: receives event+context via stdin/args, requires the handler module, calls it, writes response to stdout
- Use `asyncio.create_subprocess_exec` to run `node invoker.js` with the correct env and working directory
- Parse stdout as JSON response; parse stderr for errors
- Enforce timeout via `asyncio.wait_for` with `process.kill()` on timeout
- Consider keeping a warm Node.js process for repeated invocations (but cold start is fine for Phase 0)

---

### Task P0-14: SQLite DynamoDB Provider (IKeyValueStore Implementation) -- Table Setup and Basic CRUD
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 2 days | **Points**: 4/5
**Specs**: dynamodb-provider (Table Creation, Basic CRUD Operations, State Persistence), provider-interfaces (Key-Value Store Interface)
**Depends on**: P0-09, P0-11

**Description**: Implement the core of the SQLite-backed DynamoDB provider. Create local tables matching CDK key schemas, implement GetItem, PutItem, DeleteItem, and UpdateItem, and persist data to disk using aiosqlite. Store items as JSON blobs with indexed key columns for efficient lookups.

**Acceptance Criteria**:
- [ ] `ldk.providers.dynamodb_sqlite` implements `IKeyValueStore`
- [ ] `start()` creates SQLite database file in the configured `data_dir` and creates tables with proper schema
- [ ] SQLite table has indexed columns for partition key and sort key, plus a JSON column for the full item
- [ ] `put_item(item)` serializes and stores the item; `get_item(key)` retrieves by exact key match
- [ ] `delete_item(key)` removes by exact key match
- [ ] `update_item(key, update_expression, expression_attr_values, expression_attr_names)` applies SET and REMOVE operations
- [ ] Data persists across provider stop/start cycles (SQLite file on disk)
- [ ] `stop()` cleanly closes the aiosqlite connection
- [ ] Unit tests cover: create table, put+get, put+delete, update SET, update REMOVE, persistence across restart

**Technical Approach**:
- SQLite schema per table: `CREATE TABLE <table_name> (pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))`
- For tables without sort key, use empty string as sk default
- DynamoDB type serialization: store items as JSON with DynamoDB type descriptors (`{"S": "val"}`) preserved -- this matches SDK wire format
- Parse `UpdateExpression` string: basic regex-based parser for `SET` and `REMOVE` clauses (skip `ADD`/`DELETE` for Phase 0)
- Use `aiosqlite` for all DB operations; keep connection pool per table

---

### Task P0-15: SQLite DynamoDB Provider -- Query and Scan Operations
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: dynamodb-provider (Query Operations, Scan Operations, Global Secondary Indexes)
**Depends on**: P0-14

**Description**: Add Query and Scan operations to the SQLite DynamoDB provider. Query should support key condition expressions against the primary key and sort key. Scan should support filter expressions. Add basic GSI support by creating additional SQLite indexes.

**Acceptance Criteria**:
- [ ] `query(key_condition_expression, expression_attr_values, expression_attr_names)` returns items matching the partition key with optional sort key conditions (`=`, `<`, `>`, `<=`, `>=`, `begins_with`, `BETWEEN`)
- [ ] Query results are ordered by sort key ascending (or descending with `ScanIndexForward=False`)
- [ ] `scan(filter_expression, expression_attr_values, expression_attr_names)` returns all items, optionally filtered
- [ ] GSI support: `start()` creates additional indexed columns for each GSI; `query()` accepts `IndexName` parameter to query against GSIs
- [ ] Filter expression evaluator supports basic comparisons (`=`, `<>`, `<`, `>`) and `attribute_exists`, `attribute_not_exists`
- [ ] Unit tests cover: query by PK, query by PK+SK range, scan all, scan with filter, GSI query

**Technical Approach**:
- Parse `KeyConditionExpression` into SQL WHERE clauses: `pk = :val AND sk > :ts` -> `WHERE pk = ? AND sk > ?`
- For GSIs, create additional SQLite tables: `<table_name>__gsi__<index_name>` with the GSI key columns and item_json
- On `put_item`, also insert/update into GSI tables; on `delete_item`, also remove from GSI tables
- Filter expressions are evaluated in Python after fetch (not in SQL) for simplicity in Phase 0

---

### Task P0-16: DynamoDB Wire Protocol HTTP Server
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: dynamodb-provider (Basic CRUD Operations, Query Operations, Scan Operations), sdk-redirection (Endpoint URL Configuration)
**Depends on**: P0-14, P0-15

**Description**: Create a FastAPI HTTP server that speaks the DynamoDB wire protocol so that AWS SDKs can communicate with the local provider. The server receives POST requests with `X-Amz-Target` headers indicating the operation (e.g., `DynamoDB_20120810.GetItem`) and JSON request bodies matching the DynamoDB API shapes.

**Acceptance Criteria**:
- [ ] `ldk.providers.dynamodb_server` exposes a FastAPI app that listens on a configurable port
- [ ] Routes DynamoDB operations based on `X-Amz-Target` header: `GetItem`, `PutItem`, `DeleteItem`, `UpdateItem`, `Query`, `Scan`, `BatchGetItem`, `BatchWriteItem`
- [ ] Request bodies are parsed from DynamoDB JSON format and dispatched to the `IKeyValueStore` implementation
- [ ] Responses are serialized back to DynamoDB JSON format with correct response shapes
- [ ] Unrecognized operations return a `400` error with a descriptive message
- [ ] Integration test: use `boto3` (or `aioboto3`) to `put_item` and `get_item` against the running server

**Technical Approach**:
- Single POST endpoint at `/` that inspects `X-Amz-Target` header
- Map operations to handler functions: `{"DynamoDB_20120810.GetItem": handle_get_item, ...}`
- Each handler function translates DynamoDB API request format to `IKeyValueStore` method calls
- Use `uvicorn` to serve the FastAPI app in an asyncio task
- DynamoDB JSON uses type descriptors: `{"S": "string"}`, `{"N": "123"}`, `{"M": {...}}` -- preserve these through the stack

---

### Task P0-17: API Gateway Provider (FastAPI HTTP Server)
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: api-gateway-provider (HTTP Route Mapping, Request Transformation, Response Transformation)
**Depends on**: P0-08, P0-06

**Description**: Implement the API Gateway provider as a FastAPI server that maps CDK-defined routes to Lambda handler invocations. Transform incoming HTTP requests into API Gateway proxy integration events, invoke the appropriate Lambda handler via `ICompute`, and transform the response back to HTTP.

**Acceptance Criteria**:
- [ ] `ldk.providers.api_gateway` creates a FastAPI app with routes matching the CDK API Gateway definition
- [ ] Incoming HTTP requests are transformed into API Gateway V1 proxy integration events with: `body`, `headers`, `httpMethod`, `path`, `pathParameters`, `queryStringParameters`, `requestContext`
- [ ] Handler responses are transformed back: `statusCode` -> HTTP status, `body` -> response body, `headers` -> response headers
- [ ] Path parameters are correctly extracted (e.g., `/orders/{id}` -> `pathParameters.id`)
- [ ] Base64-encoded `body` in handler response is decoded before sending
- [ ] Multiple routes for different methods on the same path work correctly (GET vs POST)
- [ ] Integration test: start server, send HTTP request, verify handler receives correct event and client receives correct response

**Technical Approach**:
- Dynamically register FastAPI routes from the `AppModel.routes` list
- For each route, create a handler closure that: builds the proxy event dict, calls `ICompute.invoke()`, and transforms the result
- Use `fastapi.Request` to access raw body, headers, query params, path params
- Convert CDK path format (`/orders/{id}`) to FastAPI path format (same syntax, convenient)
- Serve on the configured port with uvicorn

---

### Task P0-18: Lambda Environment Variable Resolution and Injection
**Sprint**: Phase 0 - 0.3 (Minimal Local Runtime)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: lambda-runtime (Environment Variable Injection), sdk-redirection (Endpoint URL Configuration, Transparent Redirection)
**Depends on**: P0-04, P0-12, P0-13, P0-16

**Description**: Connect the reference resolver with the runtime so that Lambda function environment variables are fully resolved with local values. When a Lambda env var references a DynamoDB table name via `Ref`, it should resolve to the local table name. SDK endpoint URLs should be injected for all services that have local providers running.

**Acceptance Criteria**:
- [ ] `ldk.runtime.env_builder` module exposes `build_lambda_env(function: LambdaFunction, local_endpoints: dict, resolved_refs: dict) -> dict[str, str]`
- [ ] CDK-defined environment variables with `Ref` values are resolved to local resource names/ARNs
- [ ] CDK-defined environment variables with `Fn::GetAtt` values are resolved to local ARNs
- [ ] SDK redirection env vars are merged in: `AWS_ENDPOINT_URL_DYNAMODB`, `AWS_ENDPOINT_URL_SQS`, etc.
- [ ] User-defined (CDK) env vars take precedence for non-SDK vars; SDK endpoint vars are always injected
- [ ] Integration test: given a Lambda function referencing a table via Ref, produces env with `TABLE_NAME=<local-table-name>` and `AWS_ENDPOINT_URL_DYNAMODB=http://localhost:<port>`

**Technical Approach**:
- Accept the `LambdaFunction` model from P0-06 which has partially resolved env vars
- Apply a second resolution pass using a `local_endpoints` map: `{"MyTable": {"name": "MyTable", "endpoint": "http://localhost:8100"}}`
- Walk env var values looking for remaining `{"Ref": ...}` or `{"Fn::GetAtt": ...}` dicts, resolve against the local resource registry
- Merge SDK env vars from P0-12's `build_sdk_env()`

---

## Phase 0.4: `ldk dev` Command

### Task P0-19: Application Graph Builder
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: application-graph (Graph Construction, Trigger Relationship Mapping, Data Dependency Mapping, Dependency-Ordered Startup)
**Depends on**: P0-06

**Description**: Build the application graph from the `AppModel`. Create a directed graph where nodes are resources (Lambda functions, DynamoDB tables, API routes) and edges are trigger relationships (API -> Lambda) and data dependencies (Lambda -> DynamoDB). Compute a topological startup order so stateful resources start before compute.

**Acceptance Criteria**:
- [ ] `ldk.graph.builder` module exposes `build_graph(app_model: AppModel) -> AppGraph`
- [ ] `AppGraph` contains nodes (`GraphNode` with resource type, config) and directed edges (`GraphEdge` with edge type: `TRIGGER`, `DATA_DEPENDENCY`)
- [ ] API Gateway -> Lambda trigger edges are created from route definitions
- [ ] Lambda -> DynamoDB data dependency edges are created from environment variable references and IAM permissions
- [ ] `AppGraph.startup_order() -> list[GraphNode]` returns nodes in dependency order (tables first, then functions, then API routes)
- [ ] Circular dependency detection raises `GraphCycleError`
- [ ] Unit tests cover: simple API->Lambda->DynamoDB chain, multiple routes, startup ordering

**Technical Approach**:
- Use a simple adjacency list representation (no external graph library needed)
- Topological sort via Kahn's algorithm (BFS-based, detects cycles)
- Resource types have a natural priority: STORAGE (tables, buckets) -> COMPUTE (functions) -> TRIGGERS (API routes, event sources)
- Edges derived from: route->handler mappings, env var references to resource names, IAM policy targets

---

### Task P0-20: Orchestrator -- Provider Lifecycle Manager
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: provider-interfaces (Provider Lifecycle), application-graph (Dependency-Ordered Startup), cli (Dev Command - start/shutdown)
**Depends on**: P0-07, P0-13, P0-14, P0-16, P0-17, P0-19

**Description**: Build the orchestrator that starts and stops all local providers in the correct dependency order. Given an `AppGraph`, instantiate the appropriate provider for each resource, start them in topological order, wire triggers, and support graceful shutdown on SIGINT/SIGTERM.

**Acceptance Criteria**:
- [ ] `ldk.runtime.orchestrator` module exposes `Orchestrator` class with `async start(app_graph: AppGraph, config: LdkConfig)` and `async stop()`
- [ ] Starts DynamoDB SQLite providers for each table (with HTTP server), then Lambda compute providers for each function, then API Gateway server for routes
- [ ] Each provider's `health_check()` is called after `start()` to confirm readiness before starting dependents
- [ ] `stop()` shuts down providers in reverse startup order
- [ ] Registers `SIGINT` and `SIGTERM` handlers that call `stop()` for graceful shutdown
- [ ] Logs startup progress: `[ldk] Starting MyTable (DynamoDB)... OK`, `[ldk] Starting createOrder (Lambda)... OK`, `[ldk] API Gateway listening on http://localhost:3000`
- [ ] Integration test: start orchestrator with a simple app graph, verify all providers are running, stop cleanly

**Technical Approach**:
- Provider factory: map resource types to provider classes (`AWS::DynamoDB::Table` -> `DynamoDbSqliteProvider`, `AWS::Lambda::Function` -> `NodeJsCompute`)
- Start providers in groups by topological level (all tables in parallel, then all functions in parallel, etc.) using `asyncio.gather`
- Maintain a registry of running providers: `dict[str, Provider]` keyed by logical resource ID
- Wire triggers: tell API Gateway provider which `ICompute` instance to call for each route
- Shutdown: iterate providers in reverse order, call `stop()` on each, catch and log errors

---

### Task P0-21: CDK Synth Runner
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: cli (Dev Command - Auto-synthesis when cloud assembly is stale)
**Depends on**: P0-01

**Description**: Build a utility that checks if the `cdk.out` directory is stale (missing or older than source files) and runs `cdk synth` if needed. This is invoked at the start of `ldk dev` before parsing.

**Acceptance Criteria**:
- [ ] `ldk.cli.synth` module exposes `async ensure_synth(project_dir: Path, force: bool = False) -> Path` that returns the `cdk.out` path
- [ ] If `cdk.out/manifest.json` does not exist, runs `cdk synth`
- [ ] If any `.ts`, `.py`, `.java`, `.cs`, `.go` file in the project is newer than `cdk.out/manifest.json`, runs `cdk synth`
- [ ] Synth output (stdout/stderr) is streamed to the terminal in real-time
- [ ] If `cdk synth` fails (non-zero exit), raises `SynthError` with the stderr output
- [ ] `force=True` always runs synth regardless of staleness
- [ ] Unit tests cover: stale detection logic (mocked filesystem), synth invocation (mocked subprocess)

**Technical Approach**:
- Use `asyncio.create_subprocess_exec("npx", "cdk", "synth", ...)` to run synth
- Check staleness by comparing `cdk.out/manifest.json` mtime against `max(mtime)` of source files
- Use `pathlib.Path.rglob()` to find source files, respecting common excludes (`node_modules`, `cdk.out`, `.git`)
- Stream output via `process.stdout` and `process.stderr` async iterators

---

### Task P0-22: File Watcher with watchdog
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: hot-reload (Application Code Hot Reload, CDK Source Change Detection, Watch Path Configuration)
**Depends on**: P0-11, P0-13

**Description**: Implement basic file watching using watchdog that detects changes to Lambda handler source files and triggers module reload. For Phase 0, focus on detecting changes and invalidating the affected handler's cached module so the next invocation uses updated code. CDK source changes should trigger a re-synth notification (not automatic re-synth in Phase 0).

**Acceptance Criteria**:
- [ ] `ldk.runtime.watcher` module exposes `FileWatcher` class that watches configured paths using watchdog
- [ ] When a file in a Lambda handler's `code_path` changes, the handler's compute provider is notified to invalidate its module cache
- [ ] Watch paths respect the include/exclude patterns from `LdkConfig`
- [ ] Debouncing: rapid successive file changes (within 300ms) are batched into a single reload event
- [ ] When a CDK source file changes (`.ts` in `lib/` or `bin/`), a message is printed: `[ldk] CDK source changed. Run 'ldk dev' to re-synthesize.`
- [ ] `FileWatcher.stop()` cleanly shuts down the watchdog observer thread
- [ ] Unit tests cover: file change detection (using temp files), debouncing, exclude pattern filtering

**Technical Approach**:
- Use `watchdog.observers.Observer` and a custom `FileSystemEventHandler`
- Map filesystem paths back to handler logical IDs using the asset path registry from `AppModel`
- Debounce using an `asyncio.Task` with `asyncio.sleep(0.3)` that resets on each new event
- For Node.js module cache invalidation, notify the `NodeJsCompute` provider which spawns a fresh subprocess on next invoke
- Use `fnmatch` for glob pattern matching on include/exclude

---

### Task P0-23: Terminal Output and Status Display
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: cli (Dev Command - terminal displays summary)
**Depends on**: P0-20

**Description**: Implement the terminal output formatting for `ldk dev` including startup banner, resource summary table (routes, handlers, tables with their local endpoints), and log output formatting for invocation events.

**Acceptance Criteria**:
- [ ] Startup banner displays LDK version and project name
- [ ] Resource summary table printed after startup showing: API routes (method, path, handler, URL), DynamoDB tables (name, keys, endpoint), Lambda functions (name, runtime, handler)
- [ ] Invocation logs formatted as: `[HH:MM:SS] POST /orders -> createOrder (152ms, 200)`
- [ ] Errors displayed in red/bold (using Typer/Rich formatting)
- [ ] Hot reload events displayed: `[HH:MM:SS] Reloaded: createOrder`
- [ ] Unit tests verify output formatting functions produce correct strings

**Technical Approach**:
- Use `rich.console.Console` and `rich.table.Table` for formatted output (Rich is a Typer dependency)
- Create a `Display` class with methods: `show_banner()`, `show_resources(app_model)`, `log_invocation(method, path, handler, duration, status)`, `log_reload(handler)`, `log_error(msg)`
- Timestamp formatting with `datetime.now().strftime("%H:%M:%S")`

---

### Task P0-24: `ldk dev` CLI Command -- Full Wiring
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cli (Dev Command - all scenarios)
**Depends on**: P0-06, P0-11, P0-19, P0-20, P0-21, P0-22, P0-23

**Description**: Wire everything together into the `ldk dev` Typer CLI command. This is the main entry point that: loads config, ensures synth, parses the assembly, builds the graph, starts the orchestrator, starts the file watcher, displays the resource summary, and runs the event loop until Ctrl+C.

**Acceptance Criteria**:
- [ ] `ldk dev` command registered in Typer app with options: `--port`, `--no-persist`, `--force-synth`, `--log-level`
- [ ] Execution flow: `load_config` -> `ensure_synth` -> `parse_assembly` -> `build_graph` -> `orchestrator.start` -> `watcher.start` -> `display.show_resources` -> event loop
- [ ] `--port` overrides config file port
- [ ] `--force-synth` forces `cdk synth` even if assembly is fresh
- [ ] Ctrl+C triggers graceful shutdown: watcher stops, orchestrator stops, goodbye message
- [ ] Exit code 0 on clean shutdown, 1 on error
- [ ] Error at any stage displays a clear message and exits (e.g., "Failed to parse cloud assembly: ...")
- [ ] End-to-end test: given a test CDK project fixture, `ldk dev` starts and the API Gateway responds to HTTP requests routed through a Lambda handler that reads from DynamoDB

**Technical Approach**:
- Use Typer for CLI definition: `app = typer.Typer()`, `@app.command()` for `dev`
- Run the async orchestration in an `asyncio.run()` block
- Use `asyncio.Event` for the main loop wait, signaled by the SIGINT handler
- CLI option precedence: CLI args > config file > defaults
- Entry point in `pyproject.toml`: `ldk = "ldk.cli.main:app"`

---

### Task P0-25: End-to-End Integration Test Suite
**Sprint**: Phase 0 - 0.4 (ldk dev Command)
**Estimate**: 1 day | **Points**: 2/5
**Specs**: All Phase 0 specs
**Depends on**: P0-24

**Description**: Create a comprehensive end-to-end test that validates the full Phase 0 flow using a realistic CDK project fixture. The test should verify that a simple CRUD API (API Gateway + Lambda + DynamoDB) works end-to-end: HTTP request -> Lambda invocation -> DynamoDB read/write -> HTTP response.

**Acceptance Criteria**:
- [ ] Test fixture: `tests/fixtures/sample-app/` contains a pre-synthesized `cdk.out/` with API Gateway + Lambda + DynamoDB stack
- [ ] E2E test starts `ldk dev` programmatically (via orchestrator, not subprocess)
- [ ] Test sends HTTP POST to create an item, verifies 201 response
- [ ] Test sends HTTP GET to read the item back, verifies correct data returned
- [ ] Test verifies DynamoDB table was written to (via direct SQLite inspection or DynamoDB API)
- [ ] Test verifies environment variables were correctly injected (handler can read table name from env)
- [ ] Test verifies graceful shutdown completes without errors
- [ ] All tests pass in CI (no external dependencies needed -- Node.js required for Lambda handler)

**Technical Approach**:
- Create the test fixture by hand-crafting a minimal `cdk.out/` structure (tree.json, template, manifest, asset directory with a simple Node.js handler)
- Use `pytest-asyncio` for async test execution
- Start the orchestrator in a background task, use `httpx.AsyncClient` to send requests
- Handler fixture: simple Node.js file that does DynamoDB put/get via AWS SDK v3 (will be redirected to local)
- Tear down: stop orchestrator, assert clean shutdown, delete test SQLite files

---

## Summary

| Sub-phase | Tasks | Total Estimate | Key Deliverable |
|---|---|---|---|
| 0.1: Cloud Assembly Parser | P0-01 through P0-06 | ~7.5 days | `parse_assembly()` -> `AppModel` |
| 0.2: Provider Interfaces | P0-07 through P0-10 | ~2.5 days | `ICompute`, `IKeyValueStore`, `IQueue`, `IObjectStore`, `IEventBus`, `IStateMachine` |
| 0.3: Minimal Local Runtime | P0-11 through P0-18 | ~10 days | Working Node.js Lambda, SQLite DynamoDB, API Gateway, SDK redirection |
| 0.4: ldk dev Command | P0-19 through P0-25 | ~7 days | Fully wired `ldk dev` command with file watching |
| **Total** | **25 tasks** | **~27 days** | **End-to-end local dev environment** |

## Dependency Graph (Critical Path)

```
P0-01 (scaffolding)
  ├── P0-02 (tree.json) ──────────────┐
  ├── P0-03 (cfn templates) ──────────┤
  │     └── P0-04 (ref resolution) ───┤
  ├── P0-05 (assets) ─────────────────┤
  │                                    ├── P0-06 (orchestrator/AppModel)
  ├── P0-07 (base interface)           │     │
  │     ├── P0-08 (ICompute) ─────────│─────┤
  │     ├── P0-09 (IKeyValueStore) ───│─────┤
  │     └── P0-10 (remaining IFaces)  │     │
  ├── P0-11 (config) ─────────────────│─────┤
  │     └── P0-12 (SDK env) ──────────│─────┤
  └── P0-21 (cdk synth runner)        │     │
                                       │     │
  P0-13 (Node.js Lambda) ◄────────────│─────┤ depends on P0-08, P0-12
  P0-14 (DynamoDB CRUD) ◄─────────────│─────┤ depends on P0-09, P0-11
    └── P0-15 (Query/Scan/GSI)        │     │
          └── P0-16 (DynamoDB HTTP) ───│─────┤
  P0-17 (API Gateway) ◄───────────────┘─────┤ depends on P0-08, P0-06
  P0-18 (env var resolution) ◄──────────────┤ depends on P0-04, P0-12, P0-13, P0-16
                                             │
  P0-19 (app graph) ◄─── P0-06              │
  P0-20 (lifecycle mgr) ◄─── P0-07,13,14,16,17,19
  P0-22 (file watcher) ◄─── P0-11, P0-13
  P0-23 (terminal output) ◄─── P0-20
  P0-24 (ldk dev wiring) ◄─── P0-06,11,19,20,21,22,23
  P0-25 (E2E tests) ◄─── P0-24
```

**Critical path**: P0-01 -> P0-03 -> P0-04 -> P0-06 -> P0-17 -> P0-20 -> P0-24 -> P0-25

---

# Phase 1: Core Runtime -- Implementation Tasks

## Sub-phase 1.1: Expanded Compute Support

### Task P1-01: Python Lambda Subprocess Runner
**Sprint**: Phase 1.1 - Expanded Compute Support
**Estimate**: 2 days | **Points**: 3/5
**Specs**: lambda-runtime/spec.md - Python Handler Execution
**Depends on**: Phase 0 complete

**Description**: Implement a Python Lambda handler executor that spawns a Python subprocess, serializes the event as JSON via stdin, invokes the specified handler function, and deserializes the response from stdout. The runner must support configurable Python executable paths and handle subprocess errors gracefully.

**Acceptance Criteria**:
- [ ] A Python subprocess is spawned for each invocation with the event JSON passed via stdin
- [ ] The handler function is invoked by a bootstrap script that imports the module and calls the handler
- [ ] The deserialized response from stdout is returned to the caller
- [ ] Subprocess stderr is captured and surfaced as invocation errors
- [ ] A non-zero exit code from the subprocess results in an error response with the captured stderr
- [ ] The Python executable path is configurable (default: `python3`)

**Technical Approach**:
- Create `ldk/runtime/python_runner.py` with an async function that uses `asyncio.create_subprocess_exec`
- Create a bootstrap script template (`ldk/runtime/python_bootstrap.py`) that reads event from stdin, imports the handler module, invokes it, and writes the JSON response to stdout
- Use `json.dumps` / `json.loads` for serialization; handle `TypeError` for non-serializable responses
- Follow the same runner interface pattern as the existing Node.js runner from Phase 0

---

### Task P1-02: Python debugpy Integration
**Sprint**: Phase 1.1 - Expanded Compute Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: lambda-runtime/spec.md - Python Handler Execution, cli/spec.md - Debug Mode
**Depends on**: P1-01

**Description**: Extend the Python subprocess runner to optionally attach debugpy for remote debugging when `--inspect` is passed to `ldk dev`. The runner should inject debugpy listen configuration into the subprocess and assign incrementing ports to avoid conflicts across concurrent invocations.

**Acceptance Criteria**:
- [ ] When `--inspect` flag is active, the Python subprocess starts with `debugpy` listening on a configurable port
- [ ] The debugpy port is allocated per-function to avoid conflicts (starting from a base port, e.g., 5678)
- [ ] The terminal displays the debugpy connection URL for each function at startup
- [ ] Invocations without `--inspect` do not require debugpy to be installed
- [ ] A missing `debugpy` package produces a clear error message suggesting `pip install debugpy`

**Technical Approach**:
- Modify `python_runner.py` to prepend `debugpy` listen arguments when debug mode is enabled
- Use a port allocator that assigns ports starting from a configurable base (default 5678), incrementing per function
- Pass `--wait-for-client` only if a separate `--inspect-brk` flag is provided (block until debugger attaches)
- Log the debug URL at INFO level: `Python debugger listening on port XXXX for function <name>`

---

### Task P1-03: Lambda Context Object
**Sprint**: Phase 1.1 - Expanded Compute Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: lambda-runtime/spec.md - Lambda Context Object
**Depends on**: Phase 0 complete

**Description**: Implement a Lambda context object that provides all standard properties (`functionName`, `functionVersion`, `memoryLimitInMB`, `logGroupName`, `logStreamName`, `awsRequestId`, `invokedFunctionArn`) and a working `getRemainingTimeInMillis()` method backed by a real countdown timer.

**Acceptance Criteria**:
- [ ] `context.functionName` matches the CDK-defined function name
- [ ] `context.memoryLimitInMB` matches the CDK-defined memory setting (default 128)
- [ ] `context.awsRequestId` is a unique UUID per invocation
- [ ] `context.getRemainingTimeInMillis()` returns the wall-clock time remaining before timeout, decrementing in real time
- [ ] `context.functionVersion` defaults to `$LATEST`
- [ ] `context.invokedFunctionArn` follows the format `arn:aws:lambda:us-east-1:123456789012:function:<name>`
- [ ] The context is JSON-serializable for passing to subprocess-based runners (Python)

**Technical Approach**:
- Create `ldk/runtime/lambda_context.py` with a `LambdaContext` dataclass
- Store `_start_time` and `_timeout_ms` internally; compute `getRemainingTimeInMillis()` as `max(0, timeout_ms - elapsed)`
- For Node.js (in-process), pass as a JS-compatible object; for Python (subprocess), serialize to JSON and reconstruct in the bootstrap script
- Parse function configuration from the CDK cloud assembly (function name, memory, timeout)

---

### Task P1-04: Timeout Enforcement
**Sprint**: Phase 1.1 - Expanded Compute Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: lambda-runtime/spec.md - Timeout Enforcement
**Depends on**: P1-01, P1-03

**Description**: Implement timeout enforcement for Lambda handler invocations. Each invocation must be bounded by the CDK-configured timeout (default 3 seconds). When the timeout is exceeded, the handler process/execution is terminated and a timeout error is returned. Subsequent invocations must remain unaffected.

**Acceptance Criteria**:
- [ ] Invocations exceeding the configured timeout are terminated with a `Task timed out after X seconds` error
- [ ] The timeout value is read from the CDK cloud assembly function configuration (default 3s if not specified)
- [ ] For subprocess-based runners (Python), the subprocess is killed (SIGTERM then SIGKILL) on timeout
- [ ] For in-process runners (Node.js), the execution is cancelled via `AbortController` or equivalent
- [ ] After a timeout, the next invocation of the same function starts cleanly
- [ ] The timeout error response matches the AWS Lambda timeout error format

**Technical Approach**:
- Wrap the handler invocation in `asyncio.wait_for(coroutine, timeout=configured_timeout_seconds)`
- For subprocess runners, on `asyncio.TimeoutError`, call `process.terminate()` followed by a 1s grace period then `process.kill()`
- Return a structured error: `{"errorMessage": "Task timed out after X.XX seconds", "errorType": "TaskTimedOut"}`
- Store timeout per function from the parsed CDK template `Timeout` property (in seconds)

---

### Task P1-05: Environment Variable Resolution
**Sprint**: Phase 1.1 - Expanded Compute Support
**Estimate**: 2 days | **Points**: 3/5
**Specs**: lambda-runtime/spec.md - Environment Variable Injection
**Depends on**: Phase 0 complete

**Description**: Implement environment variable injection for Lambda functions. All environment variables defined in the CDK function configuration must be set in the handler's execution environment. CloudFormation intrinsic functions (`Ref`, `Fn::GetAtt`, `Fn::Join`, `Fn::Sub`) must be resolved to their local equivalents (e.g., a `Ref` to a DynamoDB table resolves to the local table name).

**Acceptance Criteria**:
- [ ] Static string environment variables are set verbatim in the handler's process environment
- [ ] `Ref` to a DynamoDB table resolves to the local table name
- [ ] `Ref` to an SQS queue resolves to the local queue URL
- [ ] `Fn::GetAtt` for table ARN, queue ARN, etc. resolves to a synthetic local ARN
- [ ] `Fn::Join` and `Fn::Sub` are evaluated with resolved values
- [ ] Unresolvable references produce a warning log and set the variable to a placeholder string
- [ ] Environment variables are passed to both in-process (Node.js) and subprocess (Python) runners

**Technical Approach**:
- Create `ldk/runtime/env_resolver.py` with a `resolve_environment(function_env: dict, resource_registry: ResourceRegistry) -> dict` function
- Build a `ResourceRegistry` during cloud assembly parsing that maps logical IDs to local resource identifiers (table names, queue URLs, bucket names, topic ARNs)
- Implement recursive intrinsic function resolution: handle `Ref`, `Fn::GetAtt`, `Fn::Join`, `Fn::Sub`, `Fn::Select`
- For subprocess runners, merge resolved env vars into the subprocess `env` parameter; for Node.js, set them in `process.env` before invocation

---

## Sub-phase 1.2: SQS Provider

### Task P1-06: In-Memory Queue Data Structure
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sqs-provider/spec.md - Message Send and Receive, Message Deletion, Visibility Timeout
**Depends on**: Phase 0 complete

**Description**: Implement the core in-memory queue data structure that supports enqueue, dequeue with visibility timeout, deletion by receipt handle, and re-delivery of messages whose visibility timeout has expired. This is the storage backend for the SQS provider.

**Acceptance Criteria**:
- [ ] `send_message(queue_name, body, attributes)` adds a message to the queue and returns a message ID
- [ ] `receive_messages(queue_name, max_count, visibility_timeout)` returns up to `max_count` messages and makes them invisible for `visibility_timeout` seconds
- [ ] `delete_message(queue_name, receipt_handle)` permanently removes a message
- [ ] Messages not deleted before visibility timeout expires become visible again for redelivery
- [ ] Each receive returns a unique `ReceiptHandle` string
- [ ] Queue operations are thread-safe (using `asyncio.Lock`)
- [ ] Messages include `MessageId`, `Body`, `MD5OfBody`, `MessageAttributes`, and `Attributes` (SentTimestamp, ApproximateReceiveCount)

**Technical Approach**:
- Create `ldk/providers/sqs/queue.py` with a `LocalQueue` class
- Use a list for visible messages, a dict for in-flight messages keyed by receipt handle
- Use `asyncio.Lock` for concurrency safety
- Track `ApproximateReceiveCount` per message; increment on each receive
- Use `time.monotonic()` for visibility timeout tracking; a background task or lazy evaluation on receive to re-enqueue expired messages

---

### Task P1-07: SQS API Endpoint (SendMessage, ReceiveMessage, DeleteMessage)
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 2 days | **Points**: 3/5
**Specs**: sqs-provider/spec.md - Message Send and Receive, Message Deletion, Visibility Timeout
**Depends on**: P1-06

**Description**: Implement FastAPI routes that expose the SQS API for SendMessage, ReceiveMessage, and DeleteMessage operations. These endpoints must accept the same query/form parameters as the AWS SQS API so that the AWS SDK can interact with them when the endpoint is overridden.

**Acceptance Criteria**:
- [ ] `POST /<account>/<queue-name>` with `Action=SendMessage` enqueues a message and returns an XML response with MessageId and MD5
- [ ] `POST /<account>/<queue-name>` with `Action=ReceiveMessage` returns messages in SQS XML format
- [ ] `POST /<account>/<queue-name>` with `Action=DeleteMessage` removes the message and returns success
- [ ] `VisibilityTimeout` parameter on ReceiveMessage is respected
- [ ] `MaxNumberOfMessages` parameter on ReceiveMessage is respected (default 1, max 10)
- [ ] `WaitTimeSeconds` parameter enables long-polling (wait up to N seconds for a message before returning empty)
- [ ] Response XML format matches the AWS SQS API schema so the AWS SDK parses it correctly

**Technical Approach**:
- Create `ldk/providers/sqs/routes.py` with a FastAPI `APIRouter`
- Parse the `Action` from POST form data and dispatch to the appropriate handler
- Use the `LocalQueue` from P1-06 as the backend
- Return XML responses using string templates matching the AWS SQS response format
- Register the router in the main FastAPI app with a prefix matching the SQS endpoint pattern
- Implement long-polling with `asyncio.Event` signaling on message arrival

---

### Task P1-08: SQS Queue Auto-Discovery from CDK
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sqs-provider/spec.md - Message Send and Receive
**Depends on**: P1-06

**Description**: Extend the cloud assembly parser to discover SQS queue resources (`AWS::SQS::Queue`) and their properties (queue name, visibility timeout, FIFO flag, redrive policy). Automatically create `LocalQueue` instances for each discovered queue at startup.

**Acceptance Criteria**:
- [ ] `AWS::SQS::Queue` resources are identified in the cloud assembly template
- [ ] Queue properties are extracted: `QueueName`, `VisibilityTimeout`, `FifoQueue`, `ContentBasedDeduplication`, `RedrivePolicy`
- [ ] A `LocalQueue` instance is created for each discovered queue
- [ ] FIFO queues (`.fifo` suffix) are flagged appropriately
- [ ] Queue URLs are generated in the format `http://localhost:<port>/<account-id>/<queue-name>`
- [ ] Discovered queues are registered in the `ResourceRegistry` for env var resolution

**Technical Approach**:
- Extend the cloud assembly parser in `ldk/parser/` to handle `AWS::SQS::Queue` resource type
- Create `ldk/providers/sqs/provider.py` with a `SqsProvider` class that manages queue lifecycle
- Generate deterministic local queue URLs using `000000000000` as the account ID
- Register queue name and URL mappings in the `ResourceRegistry` for cross-resource references

---

### Task P1-09: Lambda Event Source Mapping for SQS
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 2 days | **Points**: 4/5
**Specs**: sqs-provider/spec.md - Lambda Event Source Mapping
**Depends on**: P1-07, P1-04

**Description**: Implement the event source mapping that polls SQS queues and invokes connected Lambda handlers with SQS event batches. The poller must respect batch size configuration, handle handler failures (return messages to queue), and support partial batch failure reporting.

**Acceptance Criteria**:
- [ ] `AWS::Lambda::EventSourceMapping` resources linking SQS queues to Lambda functions are discovered from the cloud assembly
- [ ] A background poller task runs for each event source mapping, receiving messages and invoking the handler
- [ ] The SQS event payload passed to the handler matches the AWS SQS event format (`Records[]` with `messageId`, `body`, `receiptHandle`, etc.)
- [ ] `BatchSize` from the CDK configuration is respected (default 10)
- [ ] On successful handler invocation, messages are deleted from the queue
- [ ] On handler failure (exception/error), messages are NOT deleted (they return to queue after visibility timeout)
- [ ] The poller uses configurable polling interval (default 1 second) and backs off when the queue is empty

**Technical Approach**:
- Create `ldk/providers/sqs/event_source.py` with an `SqsEventSourcePoller` class
- Use `asyncio.create_task` for the background polling loop
- Build the SQS event payload matching the AWS format: `{"Records": [{"messageId": ..., "body": ..., "receiptHandle": ..., "attributes": ..., "messageAttributes": ..., "md5OfBody": ..., "eventSource": "aws:sqs", "eventSourceARN": ..., "awsRegion": "us-east-1"}]}`
- Invoke the connected Lambda handler through the runtime dispatcher (from Phase 0)
- Handle graceful shutdown: stop polling on SIGTERM/SIGINT

---

### Task P1-10: Dead Letter Queue Support
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sqs-provider/spec.md - Dead Letter Queue
**Depends on**: P1-06, P1-08

**Description**: Implement DLQ routing so that messages that have been received `maxReceiveCount` times without being deleted are automatically moved to the configured dead letter queue. The redrive policy is parsed from the CDK queue configuration.

**Acceptance Criteria**:
- [ ] `RedrivePolicy` is parsed from the queue's CDK properties (`deadLetterTargetArn`, `maxReceiveCount`)
- [ ] When a message's `ApproximateReceiveCount` reaches `maxReceiveCount`, it is moved to the DLQ on the next receive attempt
- [ ] Moved messages are permanently removed from the source queue
- [ ] Moved messages appear in the DLQ with their original body and attributes
- [ ] If no DLQ is configured, messages remain in the queue indefinitely (standard SQS behavior)
- [ ] The DLQ target is resolved from the logical ID in the cloud assembly to the local queue instance

**Technical Approach**:
- Extend `LocalQueue.receive_messages()` to check `ApproximateReceiveCount >= maxReceiveCount` before making a message visible again
- When the threshold is reached, call `dlq_queue.send_message(message.body, message.attributes)` instead of re-enqueuing
- Store the DLQ reference on the `LocalQueue` instance during initialization from the parsed redrive policy
- Resolve the DLQ ARN to a local queue name via the `ResourceRegistry`

---

### Task P1-11: FIFO Queue Support
**Sprint**: Phase 1.2 - SQS Provider
**Estimate**: 2 days | **Points**: 3/5
**Specs**: sqs-provider/spec.md - FIFO Queue Support
**Depends on**: P1-06

**Description**: Extend the in-memory queue to support FIFO semantics including `MessageGroupId`-based ordering and `MessageDeduplicationId`-based deduplication within a 5-minute deduplication window.

**Acceptance Criteria**:
- [ ] Messages within the same `MessageGroupId` are delivered in strict FIFO order
- [ ] Different message groups can be consumed independently (no head-of-line blocking)
- [ ] Duplicate messages (same `MessageDeduplicationId`) sent within 5 minutes are silently dropped
- [ ] `ContentBasedDeduplication` generates the dedup ID from an SHA-256 hash of the message body when enabled
- [ ] The deduplication window is exactly 5 minutes; after expiry, the same dedup ID can be reused
- [ ] FIFO queue names must end with `.fifo`
- [ ] `MessageGroupId` is required for FIFO queues; sending without it returns an error

**Technical Approach**:
- Create `ldk/providers/sqs/fifo_queue.py` extending or composing `LocalQueue`
- Use an `OrderedDict` per `MessageGroupId` to maintain ordering within groups
- Maintain a dedup cache: `dict[str, float]` mapping dedup IDs to expiry timestamps
- On `send_message`, check the dedup cache; on `receive_messages`, serve from message groups in round-robin or sequential order
- Periodically or lazily clean expired entries from the dedup cache

---

## Sub-phase 1.3: S3 Provider

### Task P1-12: Filesystem-Backed Object Storage
**Sprint**: Phase 1.3 - S3 Provider
**Estimate**: 2 days | **Points**: 3/5
**Specs**: s3-provider/spec.md - Object Storage Operations, Filesystem Persistence
**Depends on**: Phase 0 complete

**Description**: Implement the core S3 storage engine that maps bucket/key operations to the local filesystem. Support PutObject, GetObject, DeleteObject, and ListObjectsV2 operations. Objects are stored under a configurable data directory with bucket name as a subdirectory and keys mapping to file paths.

**Acceptance Criteria**:
- [ ] `put_object(bucket, key, body, content_type, metadata)` writes the object body to `<data_dir>/<bucket>/<key>` and stores metadata in a sidecar JSON file
- [ ] `get_object(bucket, key)` returns the object body, content type, and metadata; raises `NoSuchKey` if absent
- [ ] `delete_object(bucket, key)` removes the object file and its metadata sidecar
- [ ] `list_objects_v2(bucket, prefix, max_keys, continuation_token)` lists objects matching the prefix with pagination support
- [ ] Nested key paths (e.g., `docs/2024/file.txt`) create intermediate directories as needed
- [ ] Object data persists across `ldk dev` restarts (files on disk)
- [ ] Object metadata (Content-Type, user metadata, ETag, LastModified, Size) is tracked per object

**Technical Approach**:
- Create `ldk/providers/s3/storage.py` with a `LocalBucketStorage` class
- Store objects at `<data_dir>/s3/<bucket>/<key>` and metadata at `<data_dir>/s3/.metadata/<bucket>/<key>.json`
- Use `pathlib.Path` for all filesystem operations; `aiofiles` for async I/O
- Compute ETag as MD5 hex digest of the body (matching AWS behavior for non-multipart uploads)
- For `list_objects_v2`, walk the filesystem with prefix filtering; sort by key; implement continuation via offset

---

### Task P1-13: S3 API Endpoints
**Sprint**: Phase 1.3 - S3 Provider
**Estimate**: 2 days | **Points**: 3/5
**Specs**: s3-provider/spec.md - Object Storage Operations
**Depends on**: P1-12

**Description**: Implement FastAPI routes that expose S3-compatible HTTP API endpoints. The routes must support the path-style S3 API so the AWS SDK can interact with them when the endpoint is overridden.

**Acceptance Criteria**:
- [ ] `PUT /<bucket>/<key>` stores an object (PutObject)
- [ ] `GET /<bucket>/<key>` retrieves an object (GetObject) with correct Content-Type header
- [ ] `DELETE /<bucket>/<key>` removes an object (DeleteObject)
- [ ] `GET /<bucket>?list-type=2&prefix=<prefix>` returns an XML response matching the ListObjectsV2 format
- [ ] `HEAD /<bucket>/<key>` returns object metadata without body (HeadObject)
- [ ] Error responses (NoSuchKey, NoSuchBucket) return correct XML error format and HTTP status codes
- [ ] Multi-part key paths with slashes are handled correctly

**Technical Approach**:
- Create `ldk/providers/s3/routes.py` with a FastAPI `APIRouter`
- Use path parameters with a catch-all for the key: `/{bucket}/{key:path}`
- Return XML responses matching the AWS S3 XML schema
- Set response headers: `ETag`, `Content-Type`, `Content-Length`, `Last-Modified`
- Use `StreamingResponse` for GetObject to support large files efficiently

---

### Task P1-14: S3 Bucket Auto-Discovery from CDK
**Sprint**: Phase 1.3 - S3 Provider
**Estimate**: 1 day | **Points**: 1/5
**Specs**: s3-provider/spec.md - Object Storage Operations
**Depends on**: P1-12

**Description**: Extend the cloud assembly parser to discover S3 bucket resources (`AWS::S3::Bucket`) and their properties. Automatically create storage directories and register bucket endpoints for each discovered bucket.

**Acceptance Criteria**:
- [ ] `AWS::S3::Bucket` resources are identified in the cloud assembly template
- [ ] Bucket names are extracted (or generated from logical IDs if not explicitly set)
- [ ] Storage directories are created under the data directory for each bucket
- [ ] Bucket names and local endpoint URLs are registered in the `ResourceRegistry`
- [ ] Notification configurations (`NotificationConfiguration`) are extracted for use by the event notification system

**Technical Approach**:
- Extend the cloud assembly parser to handle `AWS::S3::Bucket`
- Create `ldk/providers/s3/provider.py` with an `S3Provider` class
- Parse `BucketName` property; fall back to generating a name from the logical ID with a hash suffix (matching CDK behavior)
- Extract `NotificationConfiguration.LambdaConfigurations` for event notification wiring (used by P1-15)

---

### Task P1-15: S3 Event Notifications
**Sprint**: Phase 1.3 - S3 Provider
**Estimate**: 2 days | **Points**: 3/5
**Specs**: s3-provider/spec.md - Event Notifications
**Depends on**: P1-12, P1-14, P1-04

**Description**: Implement S3 event notification dispatch so that PutObject and DeleteObject operations trigger connected Lambda handlers with correctly shaped S3 event records. Notification configurations are parsed from the CDK definition.

**Acceptance Criteria**:
- [ ] When an object is created (PutObject) in a bucket with `s3:ObjectCreated:*` notification, the connected Lambda handler is invoked
- [ ] When an object is deleted (DeleteObject) in a bucket with `s3:ObjectRemoved:*` notification, the connected handler is invoked
- [ ] The S3 event payload matches the AWS S3 event format: `{"Records": [{"eventSource": "aws:s3", "eventName": "ObjectCreated:Put", "s3": {"bucket": {"name": ...}, "object": {"key": ..., "size": ..., "eTag": ...}}}]}`
- [ ] Filter rules (`Prefix`, `Suffix`) on notification configurations are evaluated correctly
- [ ] Notifications are dispatched asynchronously (do not block the API response)

**Technical Approach**:
- Create `ldk/providers/s3/notifications.py` with a `NotificationDispatcher` class
- Hook into `LocalBucketStorage.put_object()` and `delete_object()` to fire notifications after successful operations
- Parse `NotificationConfiguration.LambdaConfigurations` from the CDK template to build a notification routing table
- Evaluate `Filter.S3KeyFilter.FilterRules` (Prefix/Suffix) before dispatching
- Use `asyncio.create_task` to dispatch invocations without blocking

---

### Task P1-16: Presigned URL Generation and Handling
**Sprint**: Phase 1.3 - S3 Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: s3-provider/spec.md - Presigned URLs
**Depends on**: P1-13

**Description**: Implement presigned URL generation and consumption. When a handler generates a presigned URL via the SDK, it should resolve to a local endpoint that serves or accepts object data without requiring credentials.

**Acceptance Criteria**:
- [ ] Presigned GET URLs return the object content when accessed via HTTP GET
- [ ] Presigned PUT URLs accept an object body via HTTP PUT and store it in the bucket
- [ ] URLs include a signature parameter that is validated (basic HMAC; prevents random URL access)
- [ ] URLs include an expiration parameter; expired URLs return 403 Forbidden
- [ ] The presigned URL host resolves to `localhost:<port>` (the local S3 endpoint)

**Technical Approach**:
- Create `ldk/providers/s3/presigned.py` with URL generation and validation functions
- Generate URLs in the format: `http://localhost:<port>/<bucket>/<key>?X-Amz-Signature=<sig>&X-Amz-Expires=<seconds>&X-Amz-Date=<date>`
- Use a local signing key (a static secret) to generate HMAC-SHA256 signatures
- Add FastAPI routes for presigned URL paths that validate the signature and expiration before delegating to storage operations
- Override the SDK's presigned URL generation by intercepting the `generate_presigned_url` call at the endpoint level

---

## Sub-phase 1.4: SNS Provider

### Task P1-17: SNS Topic Registry and Publish
**Sprint**: Phase 1.4 - SNS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sns-provider/spec.md - Publish and Subscribe
**Depends on**: Phase 0 complete

**Description**: Implement the core SNS topic registry that discovers topics from the CDK cloud assembly and supports the Publish operation. Messages published to a topic are fanned out to all registered subscribers.

**Acceptance Criteria**:
- [ ] `AWS::SNS::Topic` resources are discovered from the cloud assembly
- [ ] Topic names and ARNs are registered in the `ResourceRegistry`
- [ ] `publish(topic_arn, message, message_attributes, subject)` fans out to all subscribers
- [ ] The publish operation returns a `MessageId` (UUID)
- [ ] Publishing to a non-existent topic returns a `NotFound` error

**Technical Approach**:
- Create `ldk/providers/sns/provider.py` with an `SnsProvider` class managing a dict of topics
- Create `ldk/providers/sns/topic.py` with a `LocalTopic` class that holds a list of subscribers
- Parse `AWS::SNS::Topic` from the cloud assembly; extract `TopicName` or generate from logical ID
- The `publish` method iterates subscribers and dispatches asynchronously via `asyncio.create_task`

---

### Task P1-18: SNS API Endpoint
**Sprint**: Phase 1.4 - SNS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sns-provider/spec.md - Publish and Subscribe
**Depends on**: P1-17

**Description**: Implement the FastAPI routes for the SNS API, supporting the Publish action so the AWS SDK can interact with the local SNS provider.

**Acceptance Criteria**:
- [ ] `POST /` with `Action=Publish` publishes a message and returns an XML response with MessageId
- [ ] `TopicArn`, `Message`, `Subject`, and `MessageAttributes` parameters are parsed from the request
- [ ] The XML response format matches the AWS SNS Publish response schema
- [ ] Invalid TopicArn returns an appropriate error response

**Technical Approach**:
- Create `ldk/providers/sns/routes.py` with a FastAPI `APIRouter`
- Parse the SNS query-string/form-encoded API format (`Action`, `TopicArn`, `Message`, etc.)
- Return XML matching the AWS SNS response schema: `<PublishResponse><PublishResult><MessageId>...</MessageId></PublishResult></PublishResponse>`
- Register the router in the main FastAPI app

---

### Task P1-19: SNS-to-Lambda Subscription Dispatch
**Sprint**: Phase 1.4 - SNS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sns-provider/spec.md - Publish and Subscribe
**Depends on**: P1-17, P1-04

**Description**: Implement SNS-to-Lambda subscription wiring. When a CDK template defines an `AWS::SNS::Subscription` with protocol `lambda`, published messages should invoke the subscribed Lambda handler with a correctly shaped SNS event.

**Acceptance Criteria**:
- [ ] `AWS::SNS::Subscription` resources with `Protocol: lambda` are discovered and wired to topics
- [ ] Lambda subscribers receive an SNS event payload matching the AWS format: `{"Records": [{"EventSource": "aws:sns", "Sns": {"Message": ..., "MessageId": ..., "Subject": ..., "Timestamp": ..., "TopicArn": ..., "MessageAttributes": ...}}]}`
- [ ] Multiple Lambda subscribers on the same topic each receive the message (fan-out)
- [ ] Handler invocation failures are logged but do not prevent delivery to other subscribers

**Technical Approach**:
- Parse `AWS::SNS::Subscription` from the cloud assembly; match `TopicArn` to local topics and `Endpoint` to Lambda function ARNs
- Add each Lambda subscriber to the topic's subscriber list
- On publish, format the SNS event record and invoke each Lambda subscriber through the runtime dispatcher
- Use `asyncio.gather` with `return_exceptions=True` to handle individual subscriber failures without blocking others

---

### Task P1-20: SNS-to-SQS Subscription
**Sprint**: Phase 1.4 - SNS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sns-provider/spec.md - SQS Subscriptions
**Depends on**: P1-17, P1-07

**Description**: Implement SNS-to-SQS subscription support. When a CDK template defines an `AWS::SNS::Subscription` with protocol `sqs`, published messages should be delivered to the subscribed SQS queue wrapped in the SNS message envelope.

**Acceptance Criteria**:
- [ ] `AWS::SNS::Subscription` resources with `Protocol: sqs` are discovered and wired to topics
- [ ] Published messages are delivered to the subscribed SQS queue
- [ ] The SQS message body contains the SNS message envelope JSON: `{"Type": "Notification", "MessageId": ..., "TopicArn": ..., "Subject": ..., "Message": ..., "Timestamp": ...}`
- [ ] Multiple SQS subscribers on the same topic each receive a copy

**Technical Approach**:
- Extend the subscription parser to handle `Protocol: sqs` subscriptions
- Resolve the SQS queue from the `Endpoint` ARN via the `ResourceRegistry`
- On publish, format the SNS notification envelope and call `sqs_provider.send_message(queue_name, envelope_json)`
- Add SQS subscribers as a different subscriber type in the topic's subscriber list

---

### Task P1-21: SNS Message Filtering
**Sprint**: Phase 1.4 - SNS Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sns-provider/spec.md - Message Filtering
**Depends on**: P1-19, P1-20

**Description**: Implement SNS subscription filter policies. Subscribers with a `FilterPolicy` should only receive messages whose `MessageAttributes` match the filter conditions.

**Acceptance Criteria**:
- [ ] `FilterPolicy` is parsed from the `AWS::SNS::Subscription` properties
- [ ] Messages whose `MessageAttributes` match the filter policy are delivered to the subscriber
- [ ] Messages whose `MessageAttributes` do NOT match the filter policy are silently dropped for that subscriber
- [ ] Filter policies support exact string matching: `{"attribute": ["value1", "value2"]}`
- [ ] Filter policies support numeric matching: `{"price": [{"numeric": [">=", 100]}]}`
- [ ] A subscriber with no filter policy receives all messages
- [ ] Filter evaluation happens per-subscriber (one subscriber filtered out does not affect others)

**Technical Approach**:
- Create `ldk/providers/sns/filter.py` with a `matches_filter_policy(message_attributes, filter_policy) -> bool` function
- Implement string exact match (value in allowlist), exists check, and numeric comparison operators
- Call the filter function before dispatching to each subscriber in the topic's `publish` method
- Parse `FilterPolicy` as JSON from the subscription's CDK properties

---

## Sub-phase 1.5: Enhanced DynamoDB

### Task P1-22: Global Secondary Index Support
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 2 days | **Points**: 4/5
**Specs**: dynamodb-provider/spec.md - Global Secondary Indexes
**Depends on**: Phase 0 complete (assumes basic DynamoDB from Phase 0)

**Description**: Implement GSI support in the DynamoDB provider. GSIs defined in the CDK template should be created as additional SQLite indexes/views, and Query operations against a GSI should use the GSI's key schema.

**Acceptance Criteria**:
- [ ] `GlobalSecondaryIndexes` are parsed from the CDK table definition (index name, key schema, projection type)
- [ ] Queries specifying `IndexName` use the GSI's partition key and optional sort key for filtering
- [ ] `ALL` projection returns all item attributes; `KEYS_ONLY` returns only key attributes; `INCLUDE` returns keys plus specified non-key attributes
- [ ] GSI results are ordered by the GSI sort key when present
- [ ] Multiple GSIs on the same table are supported
- [ ] Items written to the table are automatically reflected in GSI query results

**Technical Approach**:
- Extend the DynamoDB SQLite schema to include additional indexes: `CREATE INDEX idx_<gsi_name> ON <table> (<gsi_pk>, <gsi_sk>)`
- Store GSI metadata (key schema, projection) in the provider's table configuration
- In the Query handler, detect `IndexName` parameter and rewrite the SQL query to use the GSI keys
- For `KEYS_ONLY` and `INCLUDE` projections, filter the returned attributes after the SQLite query
- Store all item data as JSON in a single SQLite column; use generated columns or expression indexes for GSI keys

---

### Task P1-23: FilterExpression Evaluation
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 2 days | **Points**: 3/5
**Specs**: dynamodb-provider/spec.md - Scan Operations
**Depends on**: Phase 0 complete

**Description**: Implement FilterExpression parsing and evaluation for DynamoDB Query and Scan operations. The filter is applied after items are read from storage but before they are returned to the caller.

**Acceptance Criteria**:
- [ ] FilterExpression with comparison operators (`=`, `<>`, `<`, `<=`, `>`, `>=`) is supported
- [ ] `AND`, `OR`, `NOT` logical operators are supported
- [ ] DynamoDB functions are supported: `attribute_exists()`, `attribute_not_exists()`, `begins_with()`, `contains()`, `size()`
- [ ] `BETWEEN` and `IN` operators are supported
- [ ] `ExpressionAttributeNames` (`#name` placeholders) are resolved
- [ ] `ExpressionAttributeValues` (`:value` placeholders) are resolved
- [ ] The filter is applied post-query (items are counted against read capacity before filtering, matching AWS behavior)

**Technical Approach**:
- Create `ldk/providers/dynamodb/expressions.py` with a `FilterExpressionEvaluator` class
- Implement a recursive descent parser or use a tokenizer to parse the expression into an AST
- Evaluate the AST against each item's attributes
- Reuse the parser for `ConditionExpression` (used in conditional writes) in the future
- Handle nested attribute paths (e.g., `address.city`) by traversing the item's attribute map

---

### Task P1-24: UpdateExpression Evaluation
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 2 days | **Points**: 4/5
**Specs**: dynamodb-provider/spec.md - Update Expressions
**Depends on**: Phase 0 complete

**Description**: Implement full UpdateExpression support for the DynamoDB provider, covering SET, REMOVE, ADD, and DELETE clauses. Each clause modifies the item's attributes in-place and the updated item is written back to SQLite.

**Acceptance Criteria**:
- [ ] `SET` clause: assigns values, supports `if_not_exists()` and `list_append()` functions, supports path expressions
- [ ] `SET` clause: supports arithmetic (`SET #q = #q + :inc`)
- [ ] `REMOVE` clause: removes attributes from the item
- [ ] `ADD` clause: adds a number to a numeric attribute or adds elements to a set
- [ ] `DELETE` clause: removes elements from a set
- [ ] Multiple clauses can be combined in a single UpdateExpression
- [ ] `ExpressionAttributeNames` and `ExpressionAttributeValues` are resolved
- [ ] Returns the updated item when `ReturnValues` is `ALL_NEW` or `UPDATED_NEW`

**Technical Approach**:
- Create `ldk/providers/dynamodb/update_expression.py` with an `UpdateExpressionEvaluator` class
- Parse the expression into clause segments (split on `SET`, `REMOVE`, `ADD`, `DELETE` keywords)
- For each SET action, parse `path = value` pairs; handle `if_not_exists(path, value)` and `list_append(list1, list2)` as special functions
- For arithmetic, detect `+` and `-` operators and evaluate against the current item value
- Apply all mutations to a copy of the item, then persist the final result

---

### Task P1-25: Batch Operations (BatchGetItem, BatchWriteItem)
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 1 day | **Points**: 2/5
**Specs**: dynamodb-provider/spec.md - Batch Operations
**Depends on**: Phase 0 complete

**Description**: Implement BatchGetItem and BatchWriteItem operations for the DynamoDB provider. These operations allow multiple items to be read or written in a single API call across one or more tables.

**Acceptance Criteria**:
- [ ] `BatchGetItem` accepts a request map of `{table_name: {Keys: [...]}}` and returns items for each table
- [ ] `BatchWriteItem` accepts a request map of `{table_name: [{PutRequest: ...} | {DeleteRequest: ...}]}` and executes all operations
- [ ] A single BatchWriteItem call supports up to 25 items; requests exceeding this return a validation error
- [ ] `UnprocessedKeys` / `UnprocessedItems` are returned as empty (all items are always processed locally)
- [ ] Operations span multiple tables correctly
- [ ] Missing items in BatchGetItem are silently omitted from results (not errors)

**Technical Approach**:
- Add `batch_get_item` and `batch_write_item` methods to the DynamoDB provider
- Iterate over the request items per table, delegating to existing `get_item`, `put_item`, and `delete_item` methods
- Validate the 25-item limit for BatchWriteItem
- Return the response in the AWS BatchGetItem/BatchWriteItem response format

---

### Task P1-26: DynamoDB Streams
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 2 days | **Points**: 4/5
**Specs**: dynamodb-provider/spec.md - DynamoDB Streams
**Depends on**: P1-04, Phase 0 complete

**Description**: Implement DynamoDB Streams that emit change events (INSERT, MODIFY, REMOVE) when items are modified. Stream events are delivered to connected Lambda handlers via event source mapping, matching the AWS DynamoDB Streams event format.

**Acceptance Criteria**:
- [ ] Tables with `StreamSpecification.StreamViewType` in the CDK definition have streams enabled
- [ ] PutItem (new item) emits an INSERT event with `NewImage`
- [ ] PutItem (overwrite) emits a MODIFY event with `OldImage` and `NewImage`
- [ ] DeleteItem emits a REMOVE event with `OldImage`
- [ ] UpdateItem emits a MODIFY event with `OldImage` and `NewImage`
- [ ] `AWS::Lambda::EventSourceMapping` linking a DynamoDB stream to a Lambda function is discovered and wired
- [ ] The event payload matches the AWS DynamoDB Streams format: `{"Records": [{"eventID": ..., "eventName": "INSERT|MODIFY|REMOVE", "dynamodb": {"Keys": ..., "NewImage": ..., "OldImage": ..., "StreamViewType": ...}}]}`
- [ ] Stream events are dispatched asynchronously and do not block the write operation

**Technical Approach**:
- Create `ldk/providers/dynamodb/streams.py` with a `StreamDispatcher` class
- Hook into `put_item`, `update_item`, and `delete_item` to capture old/new images and emit events
- Buffer stream events briefly (e.g., 100ms) and batch them before invoking the Lambda handler (matching AWS batching behavior)
- Parse `StreamSpecification.StreamViewType` to determine which images to include (`NEW_IMAGE`, `OLD_IMAGE`, `NEW_AND_OLD_IMAGES`, `KEYS_ONLY`)
- Use `asyncio.Queue` for the event buffer and a background task for dispatching

---

### Task P1-27: Eventual Consistency Simulation
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 2 days | **Points**: 3/5
**Specs**: dynamodb-provider/spec.md - Eventual Consistency Simulation
**Depends on**: P1-22

**Description**: Implement eventual consistency simulation for DynamoDB reads and GSI queries. Eventually consistent reads should serve data with a configurable delay after writes. Strongly consistent reads bypass the delay.

**Acceptance Criteria**:
- [ ] Eventually consistent reads (default, `ConsistentRead: false`) may return stale data if performed within the configured delay window after a write
- [ ] Strongly consistent reads (`ConsistentRead: true`) always return the latest data immediately
- [ ] GSI queries always exhibit eventual consistency behavior (matching AWS)
- [ ] The default delay is 200 milliseconds
- [ ] The delay is configurable via `ldk.yaml` or equivalent configuration file
- [ ] The simulation uses write timestamps to determine staleness, not actual delays in serving

**Technical Approach**:
- Maintain a write timestamp log in the DynamoDB provider: `dict[table_key, float]` mapping item keys to their last write time (`time.monotonic()`)
- For eventually consistent reads, if `current_time - last_write_time < delay`, return the previous version of the item (or nothing for new inserts)
- Store the "previous version" snapshot alongside the current version in SQLite (a `_prev_image` column or separate table)
- For GSI queries, always apply the consistency delay
- For strongly consistent reads, bypass the delay and return the latest data
- Make the delay configurable via a config key like `dynamodb.eventual_consistency_delay_ms`

---

### Task P1-28: DynamoDB State Persistence with aiosqlite
**Sprint**: Phase 1.5 - Enhanced DynamoDB
**Estimate**: 1 day | **Points**: 2/5
**Specs**: dynamodb-provider/spec.md - State Persistence
**Depends on**: Phase 0 complete

**Description**: Ensure the DynamoDB provider uses aiosqlite for all database operations and that the SQLite database file persists between `ldk dev` sessions. This task hardens the persistence layer, ensures proper connection management, and handles schema migrations.

**Acceptance Criteria**:
- [ ] All DynamoDB operations use `aiosqlite` for async SQLite access
- [ ] The SQLite database is stored at `<data_dir>/dynamodb/<table_name>.db` (one file per table)
- [ ] Table data persists across `ldk dev` restarts
- [ ] On startup, existing tables are loaded from disk without data loss
- [ ] Schema changes (e.g., new GSI added in CDK) are applied via migration without losing existing data
- [ ] Connections are properly closed on shutdown (no WAL corruption)
- [ ] Write-ahead logging (WAL) mode is enabled for concurrent read/write performance

**Technical Approach**:
- Use `aiosqlite.connect(db_path)` with `PRAGMA journal_mode=WAL` on open
- Store items as JSON blobs in a `data` column with extracted key columns for indexing
- On startup, check if the database file exists; if so, open it and verify schema; if not, create it
- For GSI migrations, add new columns/indexes via `ALTER TABLE` / `CREATE INDEX IF NOT EXISTS`
- Register a shutdown handler to close all aiosqlite connections cleanly

---

## Sub-phase 1.6: Developer Experience Polish

### Task P1-29: Structured Logging Framework
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 2 days | **Points**: 3/5
**Specs**: logging/spec.md - Structured Request Logging, Configurable Log Level
**Depends on**: Phase 0 complete

**Description**: Implement a structured logging framework that provides consistent, formatted terminal output for all LDK events. Support configurable log levels (debug, info, warn, error) and include contextual information (handler name, duration, trigger source) in every log entry.

**Acceptance Criteria**:
- [ ] HTTP request invocations are logged as: `POST /orders -> createOrder (234ms) -> 201`
- [ ] SQS message invocations are logged as: `SQS OrderQueue -> processOrder (1 msg, 156ms) -> OK`
- [ ] Log level is configurable via config file and `--log-level` CLI flag (debug, info, warn, error)
- [ ] At `debug` level, full request/response payloads are included
- [ ] At `warn` level, only warnings and errors are displayed
- [ ] At `info` level (default), request logs, reload events, and errors are displayed
- [ ] Log output uses color coding: green for success, red for errors, yellow for warnings, dim for debug
- [ ] Timestamps are included in each log line

**Technical Approach**:
- Create `ldk/logging/logger.py` with a custom `LdkLogger` class wrapping Python's `logging` module
- Use `structlog` or a custom formatter for structured output with color support (via `colorama` or `rich`)
- Define log level hierarchy: DEBUG < INFO < WARN < ERROR
- Create formatters for each event type (HTTP request, SQS invocation, S3 event, etc.)
- Integrate the logger as a singleton accessible across all providers and runtime components

---

### Task P1-30: SDK Call Instrumentation
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: logging/spec.md - SDK Call Instrumentation
**Depends on**: P1-29

**Description**: Instrument all local AWS SDK API calls (DynamoDB, SQS, S3, SNS) to log the service, operation, and resource name to the terminal. This provides developers visibility into what SDK calls their handlers are making.

**Acceptance Criteria**:
- [ ] DynamoDB calls are logged: `DynamoDB PutItem: OrdersTable (key: {orderId: "123"})`
- [ ] SQS calls are logged: `SQS SendMessage: OrderQueue`
- [ ] S3 calls are logged: `S3 PutObject: my-bucket/docs/file.txt`
- [ ] SNS calls are logged: `SNS Publish: OrderTopic`
- [ ] At `debug` level, full request and response payloads are shown
- [ ] At `info` level, only the operation summary is shown
- [ ] SDK call logs are visually indented under the parent request log

**Technical Approach**:
- Add logging hooks at the entry point of each provider's API routes
- Use a request context (e.g., `contextvars.ContextVar`) to track the parent invocation for hierarchical indentation
- Log the operation name, resource identifier, and key parameters at INFO level
- Log full request/response bodies at DEBUG level
- Use the `LdkLogger` from P1-29 with a consistent format

---

### Task P1-31: Request Flow Tracing
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 2 days | **Points**: 3/5
**Specs**: logging/spec.md - Request Flow Tracing
**Depends on**: P1-29, P1-30

**Description**: Implement end-to-end request flow tracing that shows the complete chain of handler invocations, SDK calls, and downstream triggers in a hierarchical format. A trace ID propagates through the system so related events are grouped together.

**Acceptance Criteria**:
- [ ] Each incoming request is assigned a unique trace ID
- [ ] SDK calls within a handler invocation are nested under the parent request in the log output
- [ ] Downstream triggers (e.g., SQS event source invocations triggered by an SQS SendMessage) are linked to the originating trace
- [ ] The hierarchical trace is displayed with indentation showing the call tree
- [ ] Timing is shown at each level of the trace (handler duration, SDK call duration)
- [ ] The trace summary is displayed after the root request completes

**Technical Approach**:
- Use `contextvars.ContextVar` to propagate a `TraceContext` (trace_id, parent_span_id, depth) through async call chains
- Create `ldk/logging/tracer.py` with a `Tracer` class that builds a tree of spans
- When a handler invocation triggers downstream work (e.g., SQS message triggers another handler), pass the trace ID through the internal dispatch mechanism
- After the root span completes, render the trace tree to the terminal with indentation and timing
- Store spans in a per-trace list; the root span's completion triggers the full trace output

---

### Task P1-32: Error Logging with Context
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: logging/spec.md - Error Logging with Context
**Depends on**: P1-29

**Description**: Implement rich error logging that displays handler failures with full context: the handler name, the triggering event payload, and the complete stack trace with source file locations.

**Acceptance Criteria**:
- [ ] Handler exceptions display the handler name, event source, and event payload
- [ ] The full stack trace is shown with source file paths and line numbers
- [ ] Python handler stack traces include the original Python traceback (captured from subprocess stderr)
- [ ] Node.js handler stack traces include the JavaScript error stack
- [ ] Error logs are visually distinct (red coloring, error icon/prefix)
- [ ] Large event payloads are truncated in the log output (configurable max size, default 1KB)

**Technical Approach**:
- Wrap handler invocations in try/except blocks in the runtime dispatcher
- On error, format the error message with: `[ERROR] Handler <name> failed\n  Event: <truncated_payload>\n  <stack_trace>`
- For subprocess runners, capture stderr and parse the traceback
- For Node.js runners, capture the error stack property
- Use the `LdkLogger` from P1-29 at ERROR level

---

### Task P1-33: Hot Reload Logging
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 0.5 day | **Points**: 1/5
**Specs**: logging/spec.md - Hot Reload Logging
**Depends on**: P1-29

**Description**: Add structured logging for file change detection and hot reload events. Each reload should log the changed file path, affected handler(s), and reload duration.

**Acceptance Criteria**:
- [ ] File change detection logs the changed file path: `Changed: src/handlers/createOrder.py`
- [ ] Reload completion logs the duration: `Reloaded createOrder in 120ms`
- [ ] If multiple files change simultaneously (e.g., save-all), they are batched into a single log entry
- [ ] Reload errors (syntax errors, import failures) are logged with the error message
- [ ] Logs are at INFO level (visible by default)

**Technical Approach**:
- Integrate with the existing watchdog-based file watcher from Phase 0
- Add logging calls around the reload logic: log the detected change, then log the reload result with timing
- Use `time.monotonic()` to measure reload duration
- Batch rapid successive changes (within 100ms) into a single reload log entry

---

### Task P1-34: CDK Change Detection and Incremental Apply
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 2 days | **Points**: 4/5
**Specs**: hot-reload/spec.md - CDK Source Change Detection
**Depends on**: Phase 0 complete, P1-29

**Description**: Implement CDK source file watching that detects changes to infrastructure code, automatically re-runs `cdk synth`, diffs the new cloud assembly against the current state, and applies incremental changes without restarting the entire environment.

**Acceptance Criteria**:
- [ ] CDK source files (e.g., `lib/*.ts`, `lib/*.py`) are watched for changes
- [ ] On change, `cdk synth` is automatically re-run
- [ ] The new cloud assembly is diffed against the currently loaded state
- [ ] Added resources (new routes, tables, queues) are started without restarting existing ones
- [ ] Removed resources are stopped and cleaned up
- [ ] Modified resources are updated in place where possible (e.g., changed timeout on a Lambda)
- [ ] The diff is displayed in the terminal showing added/removed/modified resources
- [ ] A synth failure is logged as an error without crashing the running environment

**Technical Approach**:
- Extend the watchdog file watcher to watch CDK source directories (detected from `cdk.json` or configured)
- On CDK file change, spawn `cdk synth` as a subprocess and await completion
- Parse the new cloud assembly and diff it against the currently loaded resource graph
- Create `ldk/reload/cdk_differ.py` that compares two parsed cloud assembly states and produces an add/remove/modify changeset
- Apply the changeset incrementally: start new providers, stop removed ones, update configurations
- Debounce rapid CDK file changes (500ms) to avoid multiple synths

---

### Task P1-35: State Persistence for SQS
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: sqs-provider/spec.md (implied by DynamoDB persistence pattern), cli/spec.md - Reset Command
**Depends on**: P1-06

**Description**: Implement state persistence for SQS queues so that in-flight and pending messages survive between `ldk dev` sessions. Use aiosqlite to persist queue state to disk.

**Acceptance Criteria**:
- [ ] Queue messages are persisted to a SQLite database at `<data_dir>/sqs/<queue_name>.db`
- [ ] On startup, pending messages are loaded from the database
- [ ] On shutdown, all in-flight and pending messages are flushed to disk
- [ ] The `ldk reset` command clears the SQS state files
- [ ] Messages that were in-flight at shutdown become visible again on restart (visibility timeout reset)

**Technical Approach**:
- Create a SQLite table per queue: `messages (message_id TEXT PRIMARY KEY, body TEXT, attributes TEXT, receive_count INTEGER, sent_timestamp REAL, visible_at REAL)`
- On `send_message`, insert into SQLite in addition to the in-memory queue
- On `delete_message`, delete from SQLite
- On startup, load all rows from SQLite into the in-memory queue
- On shutdown, persist any in-memory-only messages to SQLite

---

### Task P1-36: `ldk invoke` Command
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cli/spec.md - Invoke Command
**Depends on**: P1-04

**Description**: Implement the `ldk invoke` CLI command that directly invokes any Lambda handler with a custom event payload. The command connects to the running `ldk dev` instance and triggers the handler invocation.

**Acceptance Criteria**:
- [ ] `ldk invoke <handlerName> --event '{"key": "value"}'` invokes the handler and prints the response
- [ ] `ldk invoke <handlerName> --event-file event.json` reads the event from a file
- [ ] The response is printed as formatted JSON to stdout
- [ ] Errors are printed to stderr with the stack trace
- [ ] If no `ldk dev` session is running, the command starts a minimal runtime, invokes, and exits
- [ ] Handler names can be specified as the CDK logical ID or the function name

**Technical Approach**:
- Add a `invoke` command to the Typer CLI app in `ldk/cli/`
- If `ldk dev` is running, send an HTTP POST to a management API endpoint (e.g., `POST /_ldk/invoke`) on the running server
- If `ldk dev` is not running, perform a one-shot startup: parse cloud assembly, initialize the target function's provider, invoke, print result, and exit
- Parse the event from `--event` (inline JSON string) or `--event-file` (file path)
- Use `json.dumps(response, indent=2)` for pretty-printing the result

---

### Task P1-37: `ldk reset` Command
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 0.5 day | **Points**: 1/5
**Specs**: cli/spec.md - Reset Command
**Depends on**: P1-28, P1-35, P1-12

**Description**: Implement the `ldk reset` CLI command that clears all persisted local state including DynamoDB tables, SQS queues, and S3 objects.

**Acceptance Criteria**:
- [ ] `ldk reset` deletes all files under the `<data_dir>/` directory (DynamoDB DBs, SQS DBs, S3 objects)
- [ ] A confirmation prompt is shown before deleting (skippable with `--yes` flag)
- [ ] The command works whether or not `ldk dev` is running
- [ ] If `ldk dev` is running, it is notified to reinitialize its in-memory state
- [ ] The terminal displays what was deleted (e.g., "Cleared 3 tables, 2 queues, 1 bucket")

**Technical Approach**:
- Add a `reset` command to the Typer CLI app
- Determine the data directory from config (default `.ldk/data/`)
- Use `shutil.rmtree` to remove the entire data directory
- If `ldk dev` is running, send a POST to `/_ldk/reset` on the management API to trigger in-memory state reinit
- Count and report what was deleted by scanning the directory before removal

---

### Task P1-38: Management API for CLI Commands
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cli/spec.md - Invoke Command, Reset Command
**Depends on**: Phase 0 complete

**Description**: Implement internal management API endpoints on the running `ldk dev` server that allow CLI commands (invoke, reset, send, etc.) to interact with the live environment. These endpoints are not intended for application use.

**Acceptance Criteria**:
- [ ] `POST /_ldk/invoke` accepts `{handler: string, event: object}` and returns the invocation result
- [ ] `POST /_ldk/reset` clears all in-memory state and reinitializes providers
- [ ] `POST /_ldk/send` accepts `{queue: string, message: object}` and enqueues a message
- [ ] `GET /_ldk/status` returns the current state of all running providers and resources
- [ ] All management endpoints are prefixed with `/_ldk/` to avoid collisions with application routes
- [ ] Management endpoints return JSON responses

**Technical Approach**:
- Create `ldk/api/management.py` with a FastAPI `APIRouter` prefixed with `/_ldk`
- Each endpoint delegates to the appropriate provider or runtime component
- The `invoke` endpoint looks up the handler by name in the function registry and calls the runtime dispatcher
- The `reset` endpoint calls `provider.reset()` on each registered provider
- Mount the management router on the main FastAPI app during `ldk dev` startup

---

### Task P1-39: Graceful Shutdown and State Flush
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cli/spec.md - Graceful Shutdown
**Depends on**: P1-28, P1-35

**Description**: Implement graceful shutdown handling for `ldk dev` that ensures all state is persisted to disk, background tasks are cancelled, and resources are cleaned up when the developer presses Ctrl+C.

**Acceptance Criteria**:
- [ ] SIGINT (Ctrl+C) triggers a graceful shutdown sequence
- [ ] SIGTERM also triggers graceful shutdown (for background mode)
- [ ] All SQS event source pollers are stopped
- [ ] All DynamoDB aiosqlite connections are flushed and closed
- [ ] All SQS queue state is flushed to disk
- [ ] The FastAPI server is shut down cleanly
- [ ] A "Shutting down..." message is displayed, followed by "Goodbye" on completion
- [ ] A second Ctrl+C forces immediate exit

**Technical Approach**:
- Register signal handlers for SIGINT and SIGTERM using `asyncio.get_event_loop().add_signal_handler()`
- Create `ldk/lifecycle/shutdown.py` with a `ShutdownManager` that maintains a list of cleanup callbacks
- Each provider registers a cleanup callback at startup (e.g., `sqs_provider.flush_to_disk`, `dynamodb_provider.close_connections`)
- On signal, set a shutdown event, cancel background tasks, run cleanup callbacks in order, then exit
- On second signal, call `sys.exit(1)` immediately

---

### Task P1-40: Configuration File Support
**Sprint**: Phase 1.6 - Developer Experience Polish
**Estimate**: 1 day | **Points**: 2/5
**Specs**: logging/spec.md - Configurable Log Level, dynamodb-provider/spec.md - Eventual Consistency Simulation (configurable delay), hot-reload/spec.md - Watch Path Configuration
**Depends on**: Phase 0 complete

**Description**: Implement configuration file support (`ldk.yaml`) for user-customizable settings including log level, eventual consistency delay, watch path include/exclude patterns, data directory location, and port configuration.

**Acceptance Criteria**:
- [ ] `ldk.yaml` in the project root is loaded on startup if present
- [ ] Supported configuration keys: `log_level`, `port`, `data_dir`, `dynamodb.eventual_consistency_delay_ms`, `watch.include`, `watch.exclude`
- [ ] CLI flags override config file values (flag > config > default)
- [ ] Missing config file uses sensible defaults for all values
- [ ] Invalid config values produce clear error messages
- [ ] The configuration object is accessible throughout the application via a singleton or dependency injection

**Technical Approach**:
- Create `ldk/config.py` with a `LdkConfig` dataclass and a `load_config(project_dir, cli_overrides) -> LdkConfig` function
- Use `pyyaml` to parse `ldk.yaml`
- Define defaults: `log_level="info"`, `port=3000`, `data_dir=".ldk/data"`, `dynamodb.eventual_consistency_delay_ms=200`, `watch.exclude=["node_modules", ".git", "cdk.out", "**/*.test.*"]`
- Merge config sources in priority order: CLI args > env vars > config file > defaults
- Validate types and ranges (e.g., port must be 1-65535, delay must be non-negative)

---

## Summary

| Sub-phase | Tasks | Total Points | Estimated Days |
|-----------|-------|--------------|----------------|
| 1.1 Expanded Compute | P1-01 through P1-05 | 12/25 | 7 days |
| 1.2 SQS Provider | P1-06 through P1-11 | 16/30 | 9 days |
| 1.3 S3 Provider | P1-12 through P1-16 | 12/25 | 8 days |
| 1.4 SNS Provider | P1-17 through P1-21 | 10/25 | 5 days |
| 1.5 Enhanced DynamoDB | P1-22 through P1-28 | 22/35 | 12 days |
| 1.6 DX Polish | P1-29 through P1-40 | 24/60 | 13 days |
| **Total** | **40 tasks** | **96/200** | **~54 days** |

### Critical Path

```
Phase 0 complete
  -> P1-03 (Context) -> P1-04 (Timeout) -> P1-09 (SQS Event Source)
  -> P1-01 (Python Runner) -> P1-02 (debugpy) -> P1-04 (Timeout)
  -> P1-05 (Env Vars)
  -> P1-06 (Queue) -> P1-07 (SQS API) -> P1-09 (SQS Event Source)
  -> P1-06 (Queue) -> P1-11 (FIFO)
  -> P1-06 (Queue) -> P1-10 (DLQ)
  -> P1-12 (S3 Storage) -> P1-13 (S3 API) -> P1-16 (Presigned)
  -> P1-12 (S3 Storage) -> P1-15 (S3 Events)
  -> P1-17 (SNS Core) -> P1-19 (SNS-Lambda) -> P1-21 (Filtering)
  -> P1-17 (SNS Core) -> P1-20 (SNS-SQS) -> P1-21 (Filtering)
  -> P1-22 (GSI) -> P1-27 (Eventual Consistency)
  -> P1-29 (Logging) -> P1-30 (Instrumentation) -> P1-31 (Tracing)
  -> P1-38 (Mgmt API) -> P1-36 (ldk invoke)
```

### Parallelization Opportunities

The following sub-phases can proceed in parallel with independent teams or time-slicing:
- **1.1 (Compute)** and **1.2 (SQS)** can start simultaneously since they share only Phase 0 as a dependency
- **1.3 (S3)** and **1.4 (SNS)** can start after Phase 0, independently of each other
- **1.5 (DynamoDB)** can start immediately (extends Phase 0 DynamoDB)
- **1.6 (DX Polish)** logging tasks (P1-29 through P1-33) can start early; CLI tasks (P1-36 through P1-39) should start after the providers they interact with are ready

---

# Phase 2: Advanced Constructs -- Implementation Tasks

This document defines the implementation tasks for Phase 2 of LDK. All tasks assume Phase 0 (project bootstrap, CLI, cloud assembly parsing, configuration) and Phase 1 (Lambda runtime, API Gateway provider, DynamoDB provider, SQS provider, S3 provider, SNS provider, SDK redirection, hot reload, application graph, logging) are complete.

---

## 2.1: EventBridge Provider

### Task P2-01: IEventBus Provider Scaffold and Registration
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: provider-interfaces (Event Bus Interface), provider-interfaces (Provider Lifecycle)
**Depends on**: Phase 1 complete

**Description**: Create the EventBridge provider module implementing the `IEventBus` interface with `start`, `stop`, and `healthCheck` lifecycle methods. Register it in the provider registry so the application graph can instantiate it. Set the `AWS_ENDPOINT_URL_EVENTBRIDGE` environment variable for SDK redirection.

**Acceptance Criteria**:
- [ ] EventBridge provider class implements `IEventBus` with `publish`, `subscribe`, and `matchRules` stubs
- [ ] Provider implements `start`, `stop`, and `healthCheck` lifecycle methods
- [ ] Provider is registered in the provider registry and instantiated when EventBridge resources appear in the cloud assembly
- [ ] `AWS_ENDPOINT_URL_EVENTBRIDGE` is set for Lambda handler processes
- [ ] Unit tests verify provider lifecycle (start/stop/healthCheck)

**Technical Approach**:
- Create `ldk/providers/eventbridge/provider.py` following the pattern established by existing providers (SQS, SNS, S3)
- Register in the provider factory/registry used by the application graph
- Expose a FastAPI router for the EventBridge SDK API surface (PutEvents, PutRule, ListRules)
- Store event bus state in-memory (event buses are ephemeral)

---

### Task P2-02: Event Pattern Matching Engine
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 2 days | **Points**: 4/5
**Specs**: eventbridge-provider (Event Pattern Matching)
**Depends on**: P2-01

**Description**: Implement the EventBridge event pattern matching engine supporting exact value matching, prefix matching, numeric range matching, exists/not-exists patterns, and anything-but patterns. The engine takes a pattern (JSON) and an event (JSON) and returns whether the event matches.

**Acceptance Criteria**:
- [ ] Exact value matching works for string arrays: `{"source": ["orders"]}` matches `source: "orders"`
- [ ] Multiple values in a pattern field use OR logic: `{"detail-type": ["OrderCreated", "OrderUpdated"]}` matches either
- [ ] Prefix matching works: `{"source": [{"prefix": "com.myapp"}]}`
- [ ] Numeric range matching works: `{"detail": {"price": [{"numeric": [">", 0, "<=", 100]}]}}`
- [ ] Nested field matching works on `detail` sub-fields
- [ ] Non-matching events are correctly rejected
- [ ] Unit tests cover all pattern types with positive and negative cases

**Technical Approach**:
- Create `ldk/providers/eventbridge/pattern_matcher.py` as a pure function: `match_event(pattern: dict, event: dict) -> bool`
- Implement recursive matching for nested patterns
- Follow the AWS EventBridge content-based filtering rules documented in the spec
- Test edge cases: empty patterns (match all), missing fields (no match), nested detail patterns

---

### Task P2-03: Event Bus Publish and Rule Routing
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: eventbridge-provider (Event Bus), eventbridge-provider (Event Pattern Matching)
**Depends on**: P2-02

**Description**: Implement the `PutEvents` API endpoint that accepts events and routes them to matching rules. When an event matches a rule, invoke the rule's target (Lambda handler) with the event payload formatted as an EventBridge event envelope. Parse rules from the cloud assembly (CDK-defined EventBridge rules).

**Acceptance Criteria**:
- [ ] `PutEvents` API accepts one or more events and returns the expected EventBridge response shape
- [ ] Rules are parsed from the cloud assembly and registered with their patterns and targets
- [ ] When a published event matches a rule pattern, the target Lambda handler is invoked with the event
- [ ] The event envelope includes `source`, `detail-type`, `detail`, `time`, `id`, `region`, `account`, `resources` fields
- [ ] Events that match no rules are silently dropped (no error)
- [ ] Events matching multiple rules invoke all matching targets
- [ ] Integration test: publish event -> rule matches -> Lambda handler invoked with correct payload

**Technical Approach**:
- Implement `PutEvents` as a FastAPI POST route on the EventBridge router
- Parse `AWS::Events::Rule` resources from cloud assembly to extract `EventPattern` and `Targets`
- Use the Lambda runtime's invocation mechanism to invoke target handlers
- Generate unique event IDs and timestamps for the event envelope

---

### Task P2-04: Scheduled Rules with Croniter
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: eventbridge-provider (Scheduled Rules)
**Depends on**: P2-03

**Description**: Implement EventBridge scheduled rules that use cron expressions to invoke target Lambda handlers on a schedule. Parse `ScheduleExpression` from CDK-defined rules and use `croniter` to determine next invocation times. Run a background task that checks for due schedules.

**Acceptance Criteria**:
- [ ] Cron expressions from CDK rules (e.g., `cron(0 9 * * ? *)`) are parsed using croniter
- [ ] Rate expressions (e.g., `rate(5 minutes)`) are also supported
- [ ] A background asyncio task polls for due scheduled rules and invokes their targets
- [ ] The scheduled event payload matches the AWS EventBridge scheduled event format
- [ ] Scheduled rules start executing when `ldk dev` starts and stop on shutdown
- [ ] Terminal output logs each scheduled invocation with the rule name and timestamp
- [ ] Unit tests verify cron parsing and next-fire-time calculation
- [ ] Integration test: define schedule rule -> wait for trigger -> verify handler invoked

**Technical Approach**:
- Parse `ScheduleExpression` field from `AWS::Events::Rule` resources in the cloud assembly
- Convert AWS cron format (`cron(...)`) to standard cron format for croniter
- Run an `asyncio.create_task` loop that sleeps until the next scheduled event, then invokes the target
- For rate expressions, convert to a simple interval (e.g., `rate(5 minutes)` -> 300 seconds)
- Store last invocation time to avoid double-firing on restart

---

### Task P2-05: Cross-Service Event Routing
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: eventbridge-provider (Cross-Service Event Routing)
**Depends on**: P2-03

**Description**: Implement cross-service event routing so that events from other LDK providers (S3, DynamoDB Streams, etc.) can be published to EventBridge and matched against rules. Create an internal event bus API that other providers call to emit events.

**Acceptance Criteria**:
- [ ] S3 provider can emit `Object Created` events to EventBridge when bucket is configured with EventBridge notifications
- [ ] Events from other providers use the correct AWS source format (e.g., `aws.s3`, `aws.dynamodb`)
- [ ] EventBridge rules matching cross-service events correctly invoke their Lambda targets
- [ ] The internal publish API is available to all providers without circular dependencies
- [ ] Integration test: S3 putObject -> EventBridge rule matches -> Lambda handler invoked

**Technical Approach**:
- Create an internal event publishing function in the EventBridge provider that other providers import
- Modify the S3 provider to check for EventBridge notification configuration and call the publish function
- Use the application graph to detect when a bucket has `EventBridgeEnabled: true` in the cloud assembly
- Format cross-service events with the correct AWS event schema (source, detail-type, detail)

---

### Task P2-06: EventBridge Provider Cloud Assembly Parsing
**Sprint**: Phase 2 - EventBridge Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: eventbridge-provider (Event Bus), cloud-assembly-parsing
**Depends on**: P2-01

**Description**: Extend the cloud assembly parser to extract EventBridge resources: event buses (`AWS::Events::EventBus`), rules (`AWS::Events::Rule`), and their targets. Map rule targets to Lambda function logical IDs so the provider can resolve them to local handlers.

**Acceptance Criteria**:
- [ ] Parser extracts `AWS::Events::EventBus` resources with name and properties
- [ ] Parser extracts `AWS::Events::Rule` resources with `EventPattern`, `ScheduleExpression`, `EventBusName`, and `Targets`
- [ ] Rule targets referencing Lambda functions are resolved to the correct handler entries in the application graph
- [ ] Default event bus is created when rules reference it implicitly
- [ ] Unit tests with sample CloudFormation template snippets

**Technical Approach**:
- Extend the existing cloud assembly parser module to handle Events resource types
- Add event bus and rule nodes to the application graph
- Create edges from rules to their Lambda targets in the graph

---

## 2.2: Step Functions Provider

### Task P2-07: IStateMachine Provider Scaffold and ASL Parser
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: provider-interfaces (State Machine Interface), stepfunctions-provider (Core ASL State Support)
**Depends on**: Phase 1 complete

**Description**: Create the Step Functions provider implementing `IStateMachine` with lifecycle methods. Build an ASL (Amazon States Language) definition parser that reads state machine definitions from the cloud assembly and constructs an internal representation of states, transitions, and configuration.

**Acceptance Criteria**:
- [ ] Step Functions provider class implements `IStateMachine` with `startExecution` stub
- [ ] Provider implements `start`, `stop`, and `healthCheck` lifecycle methods
- [ ] ASL parser reads JSON state machine definitions and creates an internal state graph
- [ ] Parser correctly identifies all state types: Task, Choice, Wait, Parallel, Map, Pass, Succeed, Fail
- [ ] Parser extracts `StartAt`, `States`, `Next`, `End`, `Comment` fields
- [ ] Unit tests verify parsing of a multi-state ASL definition

**Technical Approach**:
- Create `ldk/providers/stepfunctions/provider.py` with the provider class
- Create `ldk/providers/stepfunctions/asl_parser.py` for definition parsing
- Model states as dataclasses: `TaskState`, `ChoiceState`, `WaitState`, etc.
- Extract `AWS::StepFunctions::StateMachine` resources from cloud assembly, read `DefinitionString` or `DefinitionS3Location`

---

### Task P2-08: State Machine Execution Engine Core
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 2 days | **Points**: 4/5
**Specs**: stepfunctions-provider (Core ASL State Support)
**Depends on**: P2-07

**Description**: Implement the core execution engine that walks through an ASL state machine. The engine starts at the `StartAt` state, processes each state according to its type, follows `Next` transitions, and terminates at `End: true` or a terminal state (Succeed/Fail). Support Pass and Succeed/Fail states in this task.

**Acceptance Criteria**:
- [ ] Execution engine starts at the `StartAt` state and follows `Next` transitions
- [ ] Pass state correctly passes input to output, with optional `Result` and `ResultPath` processing
- [ ] Succeed state terminates execution with success status
- [ ] Fail state terminates execution with error and cause information
- [ ] `InputPath`, `OutputPath`, and `ResultPath` processing works on all states
- [ ] Execution returns final output and status (SUCCEEDED, FAILED)
- [ ] Unit tests: Pass -> Pass -> Succeed chain; Fail state with error; InputPath/OutputPath filtering

**Technical Approach**:
- Create `ldk/providers/stepfunctions/engine.py` with an `ExecutionEngine` class
- Use JSONPath evaluation for `InputPath`, `OutputPath`, `ResultPath` (use a lightweight JSONPath library or implement subset)
- Each state type has an `execute` method that returns the next state name and output
- Track execution as a list of state transitions with timestamps

---

### Task P2-09: Task State with Lambda Invocation
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: stepfunctions-provider (Task State Lambda Invocation)
**Depends on**: P2-08

**Description**: Implement the Task state that invokes Lambda handlers. The Task state reads its `Resource` ARN to identify the target Lambda function, applies `InputPath`/`Parameters` to construct the handler input, invokes the handler via the Lambda runtime, and applies `ResultPath`/`OutputPath` to the response.

**Acceptance Criteria**:
- [ ] Task state resolves `Resource` ARN to a local Lambda handler
- [ ] Handler is invoked with input processed through `InputPath` and `Parameters`
- [ ] Handler response is placed at `ResultPath` in the state output
- [ ] `OutputPath` filters the final state output
- [ ] `Parameters` with `.$` suffix fields perform JSONPath extraction from input
- [ ] Task state transitions to `Next` state on success
- [ ] Integration test: state machine with Task state invokes actual Lambda handler and produces correct output

**Technical Approach**:
- Resolve Lambda ARN from the cloud assembly by matching the logical ID in the `Resource` field
- Call the Lambda runtime's invocation function directly (in-process, not via HTTP)
- Implement `Parameters` template processing with JSONPath substitution for `.$` fields
- Handle `TimeoutSeconds` on Task state by enforcing a deadline

---

### Task P2-10: Choice State Branching
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: stepfunctions-provider (Choice State Branching)
**Depends on**: P2-08

**Description**: Implement the Choice state that evaluates comparison rules against the input and branches to the matching state. Support comparison operators: StringEquals, StringGreaterThan, NumericEquals, NumericGreaterThan, NumericLessThan, BooleanEquals, IsPresent, IsString, IsNumeric, and their negated/combined variants (And, Or, Not).

**Acceptance Criteria**:
- [ ] StringEquals, StringGreaterThan, StringLessThan, StringGreaterThanEquals, StringLessThanEquals comparisons work
- [ ] NumericEquals, NumericGreaterThan, NumericLessThan, NumericGreaterThanEquals, NumericLessThanEquals comparisons work
- [ ] BooleanEquals comparison works
- [ ] IsPresent, IsNull, IsString, IsNumeric, IsBoolean type checks work
- [ ] And, Or, Not combinators work with nested rules
- [ ] `Default` state is used when no choice rule matches
- [ ] Missing `Default` with no matching rule produces an error
- [ ] Unit tests: multiple choice branches, nested And/Or/Not, default fallthrough

**Technical Approach**:
- Create `ldk/providers/stepfunctions/choice_evaluator.py` with a rule evaluation function
- Use `Variable` field as JSONPath to extract the comparison value from input
- Implement each comparison operator as a function, compose with And/Or/Not
- Return the `Next` state name from the first matching choice rule, or `Default`

---

### Task P2-11: Wait State Implementation
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 0.5 days | **Points**: 1/5
**Specs**: stepfunctions-provider (Core ASL State Support)
**Depends on**: P2-08

**Description**: Implement the Wait state supporting `Seconds`, `Timestamp`, `SecondsPath`, and `TimestampPath` wait configurations. In local dev mode, optionally compress wait times to avoid long pauses.

**Acceptance Criteria**:
- [ ] `Seconds` waits for the specified number of seconds (or compressed equivalent)
- [ ] `Timestamp` waits until the specified ISO 8601 timestamp
- [ ] `SecondsPath` extracts wait duration from input via JSONPath
- [ ] `TimestampPath` extracts timestamp from input via JSONPath
- [ ] A configuration option allows compressing wait times (e.g., max 1 second) for fast local iteration
- [ ] Wait state transitions to `Next` after waiting
- [ ] Unit tests verify each wait mode

**Technical Approach**:
- Use `asyncio.sleep` for the wait duration
- Parse ISO 8601 timestamps with `datetime.fromisoformat`
- Add a `stepfunctions.max_wait_seconds` configuration option (default: compress to 1 second locally)
- For `SecondsPath`/`TimestampPath`, reuse the JSONPath extraction from the engine

---

### Task P2-12: Retry and Catch Error Handling
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 2 days | **Points**: 4/5
**Specs**: stepfunctions-provider (Retry and Catch Error Handling)
**Depends on**: P2-09

**Description**: Implement Retry and Catch configurations on Task states. Retry should match error names, apply `MaxAttempts`, `IntervalSeconds`, and `BackoffRate`. Catch should match error names and transition to a fallback state with error information injected via `ResultPath`.

**Acceptance Criteria**:
- [ ] Retry matches error names including `States.ALL`, `States.TaskFailed`, `States.Timeout`, and custom error names
- [ ] Retry respects `MaxAttempts` (default 3), `IntervalSeconds` (default 1), and `BackoffRate` (default 2.0)
- [ ] After exhausting retries, execution falls through to Catch or fails
- [ ] Catch matches error names and transitions to the specified `Next` state
- [ ] Catch injects error information (`Error` and `Cause`) at the configured `ResultPath`
- [ ] Multiple Retry and Catch entries are evaluated in order
- [ ] `States.ALL` matches any error
- [ ] Unit tests: retry succeeds on 2nd attempt, retry exhausted falls to Catch, Catch routes to error handler, backoff timing

**Technical Approach**:
- Wrap Task state execution in a retry loop that catches exceptions
- Map Python exceptions to Step Functions error names (timeout -> `States.Timeout`, etc.)
- Implement exponential backoff: `IntervalSeconds * (BackoffRate ^ attempt)`
- For Catch, create a new state input with error info and transition to the Catch target state
- Compress retry wait times locally (same as Wait state compression)

---

### Task P2-13: Parallel State Execution
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: stepfunctions-provider (Parallel and Map States)
**Depends on**: P2-09, P2-10

**Description**: Implement the Parallel state that executes multiple branches concurrently. Each branch is a complete sub-state-machine. The Parallel state output is an array of results, one per branch, in the order the branches are defined.

**Acceptance Criteria**:
- [ ] Parallel state executes all defined branches
- [ ] Each branch receives the same input (after `InputPath` processing)
- [ ] Branches execute concurrently using asyncio
- [ ] Output is an array of branch results in definition order
- [ ] If any branch fails, the Parallel state fails (unless Catch is configured)
- [ ] `ResultPath` and `OutputPath` apply to the Parallel state output
- [ ] Retry and Catch work on Parallel states
- [ ] Integration test: Parallel with two Task branches -> array of two results

**Technical Approach**:
- Reuse the `ExecutionEngine` to execute each branch as a sub-state-machine
- Use `asyncio.gather` to run branches concurrently
- Collect results in branch definition order
- On branch failure, cancel remaining branches and propagate error (for Retry/Catch)

---

### Task P2-14: Map State Execution
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: stepfunctions-provider (Parallel and Map States)
**Depends on**: P2-13

**Description**: Implement the Map state that iterates over an array in the input and executes an iterator state machine for each item. Support `ItemsPath` to locate the array, `MaxConcurrency` to limit parallel iterations, and `Parameters` to construct per-item input.

**Acceptance Criteria**:
- [ ] Map state extracts array from input using `ItemsPath` (default `$`)
- [ ] Iterator state machine executes once per array item
- [ ] `MaxConcurrency` limits concurrent iterations (0 = unlimited)
- [ ] `Parameters` template constructs per-item input with `$$.Map.Item.Value` and `$$.Map.Item.Index` context
- [ ] Output is an array of results in input order
- [ ] If any iteration fails, the Map state fails (unless Catch configured)
- [ ] Unit tests: Map over 5 items, MaxConcurrency=2, Parameters with context object

**Technical Approach**:
- Use `asyncio.Semaphore(max_concurrency)` for concurrency control (when `MaxConcurrency > 0`)
- Reuse the execution engine for each iteration's sub-state-machine
- Build per-item input by injecting `$$.Map.Item.Value` and `$$.Map.Item.Index` into `Parameters`
- Collect results preserving input array order

---

### Task P2-15: Execution Tracking and Terminal Output
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: stepfunctions-provider (Execution Tracking)
**Depends on**: P2-08

**Description**: Implement execution history tracking that records each state transition with the state name, state type, input, output, duration, and status. Display execution traces in terminal output using the existing logging system. Store execution history for retrieval via a `DescribeExecution`-like API.

**Acceptance Criteria**:
- [ ] Each state transition is recorded with: state name, type, input (truncated), output (truncated), duration, status
- [ ] Terminal output shows a formatted execution trace on completion: state name, duration, status per state
- [ ] Execution history is stored in-memory and retrievable by execution ARN
- [ ] `ListExecutions` and `DescribeExecution` API endpoints return execution data
- [ ] Failed executions show the error state and error details in the trace
- [ ] Parallel/Map branch transitions are indented in the trace output

**Technical Approach**:
- Add an `ExecutionHistory` dataclass that accumulates `StateTransition` records
- Pass the history object through the engine as executions proceed
- Use the existing logging module to format and display traces
- Expose FastAPI endpoints for `ListExecutions` and `DescribeExecution`

---

### Task P2-16: Workflow Type Support (Express vs Standard)
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: stepfunctions-provider (Workflow Type Support)
**Depends on**: P2-15

**Description**: Implement behavioral differences between Express and Standard workflow types. Express workflows execute synchronously (the `StartExecution` API blocks and returns the result). Standard workflows execute asynchronously (return execution ARN immediately, poll `DescribeExecution` for result).

**Acceptance Criteria**:
- [ ] `Type: EXPRESS` state machines execute synchronously: `StartSyncExecution` API blocks and returns final output
- [ ] `Type: STANDARD` state machines execute asynchronously: `StartExecution` returns execution ARN immediately
- [ ] Standard workflow results are retrievable via `DescribeExecution` polling
- [ ] Workflow type is parsed from the cloud assembly `AWS::StepFunctions::StateMachine` resource
- [ ] Default workflow type is STANDARD when not specified
- [ ] Unit tests verify synchronous vs asynchronous behavior

**Technical Approach**:
- For Express: await the execution engine directly in the API handler and return the result
- For Standard: launch execution as a background `asyncio.Task` and return the execution ARN
- Store active executions in a dict keyed by execution ARN for `DescribeExecution` lookups

---

### Task P2-17: Step Functions Cloud Assembly Parsing
**Sprint**: Phase 2 - Step Functions Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: stepfunctions-provider (Core ASL State Support), cloud-assembly-parsing
**Depends on**: P2-07

**Description**: Extend the cloud assembly parser to extract Step Functions resources. Parse `AWS::StepFunctions::StateMachine` resources to extract the ASL definition, workflow type, and role. Resolve Lambda ARNs in Task states to local handler references.

**Acceptance Criteria**:
- [ ] Parser extracts `AWS::StepFunctions::StateMachine` resources from cloud assembly
- [ ] `DefinitionString` (inline JSON) is parsed into ASL definition
- [ ] `DefinitionSubstitutions` are resolved (replacing `${Token}` references with local values)
- [ ] Workflow `Type` (STANDARD/EXPRESS) is extracted
- [ ] Lambda function ARNs in Task state `Resource` fields are resolved to local handler entries
- [ ] State machine nodes are added to the application graph with edges to their Lambda targets
- [ ] Unit tests with sample CloudFormation template containing a state machine definition

**Technical Approach**:
- Extend the cloud assembly parser to handle `AWS::StepFunctions::StateMachine`
- Use `Fn::Sub` and `DefinitionSubstitutions` resolution to replace ARN tokens with local references
- Add state machine as a node in the application graph, with trigger edges to/from Lambda functions

---

## 2.3: ECS Service Support

### Task P2-18: ECS Provider Scaffold and Process Manager
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: ecs-provider (Long-Running Process Execution), provider-interfaces (Compute Interface, Provider Lifecycle)
**Depends on**: Phase 1 complete

**Description**: Create the ECS provider that manages long-running local processes. Implement a process manager that starts container commands as local subprocesses, captures stdout/stderr, and manages process lifecycle (start, stop, signal handling).

**Acceptance Criteria**:
- [ ] ECS provider starts a local subprocess for each ECS service/task definition
- [ ] The subprocess command is derived from the container definition's `command` and `entryPoint`
- [ ] Environment variables from the task definition are injected into the subprocess
- [ ] stdout and stderr are captured and streamed to the terminal with service-name prefix
- [ ] Processes run continuously until explicitly stopped
- [ ] `stop` lifecycle method sends SIGTERM and waits for graceful shutdown
- [ ] If process does not exit within timeout, SIGKILL is sent
- [ ] Unit tests verify process start and stop lifecycle

**Technical Approach**:
- Create `ldk/providers/ecs/provider.py` with an `ECSProvider` class
- Create `ldk/providers/ecs/process_manager.py` using `asyncio.create_subprocess_exec`
- Stream stdout/stderr via `asyncio.StreamReader` with service-name prefix in log lines
- Store process handles in a dict keyed by service name

---

### Task P2-19: ECS Cloud Assembly Parsing
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: ecs-provider (Long-Running Process Execution), cloud-assembly-parsing
**Depends on**: P2-18

**Description**: Extend the cloud assembly parser to extract ECS resources: task definitions (`AWS::ECS::TaskDefinition`), services (`AWS::ECS::Service`), and container definitions. Extract container image, command, environment variables, port mappings, and health check configuration.

**Acceptance Criteria**:
- [ ] Parser extracts `AWS::ECS::TaskDefinition` with container definitions
- [ ] Container image, command, entryPoint, environment, and portMappings are extracted
- [ ] Health check configuration (`command`, `interval`, `timeout`, `retries`, `startPeriod`) is extracted
- [ ] `AWS::ECS::Service` resources are linked to their task definitions
- [ ] ECS service nodes are added to the application graph
- [ ] Unit tests with sample CloudFormation template containing ECS resources

**Technical Approach**:
- Extend cloud assembly parser to handle ECS resource types
- For local development, the container image reference is used to determine the local command (e.g., if the Dockerfile is available, derive the start command)
- Support a `ldk.local_command` override in configuration for when the Docker image isn't directly runnable

---

### Task P2-20: Health Check Polling
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: ecs-provider (Health Check Polling)
**Depends on**: P2-18

**Description**: Implement health check polling for ECS services. Periodically send HTTP requests to the configured health check endpoint and update the service status. Display health status in terminal output. Mark services as healthy/unhealthy based on response codes.

**Acceptance Criteria**:
- [ ] Health check endpoint is polled at the configured interval (default 30 seconds)
- [ ] HTTP 200 response marks the service as healthy
- [ ] Non-200 response or timeout marks the service as unhealthy
- [ ] Health status is displayed in terminal output with the service name
- [ ] Health check respects `startPeriod` (grace period before first check)
- [ ] Health check respects `retries` (consecutive failures before marking unhealthy)
- [ ] `healthCheck` lifecycle method returns current health status
- [ ] Unit tests with mock HTTP server verify health check behavior

**Technical Approach**:
- Create `ldk/providers/ecs/health_checker.py` with an async polling loop
- Use `httpx.AsyncClient` or `aiohttp` for health check HTTP requests
- Track consecutive failures and apply retry threshold before marking unhealthy
- Integrate with the logging system for health status output

---

### Task P2-21: Graceful Restart on Code Changes
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: ecs-provider (Graceful Restart on Code Changes), hot-reload (ECS Service Graceful Restart)
**Depends on**: P2-18, P2-20

**Description**: Integrate the ECS provider with the hot-reload file watcher. When source code changes are detected for an ECS service, trigger a graceful restart: send SIGTERM, wait for a configurable grace period, send SIGKILL if still running, then start a new process with the updated code.

**Acceptance Criteria**:
- [ ] File watcher detects changes to ECS service source code directories
- [ ] On change, SIGTERM is sent to the running service process
- [ ] Grace period (configurable, default 10 seconds) is observed before SIGKILL
- [ ] New process is started with the same configuration after the old process terminates
- [ ] Health check polling resumes for the new process
- [ ] Terminal output shows restart progress (stopping, waiting, starting)
- [ ] Rapid successive changes are debounced (only one restart)
- [ ] Integration test: modify a file -> service restarts with new code

**Technical Approach**:
- Register ECS service source directories with the existing watchdog file watcher
- Create a `restart_service(service_name)` method on the process manager
- Use `asyncio.wait_for` with the grace period timeout before escalating to SIGKILL
- Debounce file change events with a 500ms delay to avoid multiple restarts

---

### Task P2-22: Service Discovery
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1 day | **Points**: 2/5
**Specs**: ecs-provider (Service Discovery)
**Depends on**: P2-18

**Description**: Implement local service discovery so that Lambda handlers and other services can find and connect to running ECS services. Register service endpoints (host:port) and make them available via environment variables and a local DNS-like resolution mechanism.

**Acceptance Criteria**:
- [ ] Each ECS service registers its local endpoint (localhost:port) on startup
- [ ] Lambda handlers receive environment variables with service endpoints (matching the CDK-defined env vars)
- [ ] Service discovery entries are updated when services restart on different ports
- [ ] A service registry API allows querying available services and their endpoints
- [ ] Other ECS services can discover peer services via environment variable injection
- [ ] Unit tests verify service registration and discovery

**Technical Approach**:
- Create `ldk/providers/ecs/service_registry.py` maintaining a dict of service name -> endpoint
- On ECS service start, register the endpoint; on stop, deregister
- Resolve `Fn::GetAtt` and `Ref` references in Lambda environment variables that point to ECS service endpoints
- Inject `AWS_ENDPOINT_URL_*` style variables or direct host:port values as appropriate

---

### Task P2-23: ALB Integration and HTTP Routing
**Sprint**: Phase 2 - ECS Service Support
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: ecs-provider (Load Balancer Integration)
**Depends on**: P2-22

**Description**: Implement Application Load Balancer integration for ECS services. Parse ALB listener rules from the cloud assembly (path-based routing, host-based routing) and configure the local HTTP server to proxy matching requests to the appropriate ECS service process.

**Acceptance Criteria**:
- [ ] ALB listener rules are parsed from `AWS::ElasticLoadBalancingV2::ListenerRule` resources
- [ ] Path-based routing patterns (e.g., `/api/*`) are configured on the local HTTP server
- [ ] HTTP requests matching the path pattern are proxied to the ECS service's local port
- [ ] Health check path is also routed through the ALB listener
- [ ] Multiple target groups routing to different services work correctly
- [ ] Response headers and status codes are passed through transparently
- [ ] Integration test: HTTP request -> ALB path match -> proxied to ECS service -> response returned

**Technical Approach**:
- Parse `AWS::ElasticLoadBalancingV2::*` resources from cloud assembly
- Add proxy routes to the existing FastAPI HTTP server using `httpx.AsyncClient` for proxying
- Match path patterns using FastAPI path parameters or regex routes
- Forward the full request (method, headers, body) and return the full response

---

## 2.4: Cognito Provider

### Task P2-24: Cognito Provider Scaffold and User Store
**Sprint**: Phase 2 - Cognito Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cognito-provider (User Pool Operations)
**Depends on**: Phase 1 complete

**Description**: Create the Cognito provider with a local user store backed by aiosqlite. Implement user sign-up (store email/password hash) and user confirmation. Parse user pool configuration (password policy, required attributes) from the cloud assembly.

**Acceptance Criteria**:
- [ ] Cognito provider creates an aiosqlite database for user storage
- [ ] `SignUp` API accepts username, password, and user attributes (email, etc.)
- [ ] Passwords are hashed using bcrypt or argon2 before storage
- [ ] Password policy from CDK (min length, require uppercase/lowercase/numbers/symbols) is enforced
- [ ] Required attributes from CDK user pool are validated on sign-up
- [ ] `ConfirmSignUp` API marks a user as confirmed (auto-confirm in local mode by default)
- [ ] Duplicate username is rejected with `UsernameExistsException`
- [ ] Unit tests verify sign-up, confirmation, and password policy enforcement

**Technical Approach**:
- Create `ldk/providers/cognito/provider.py` with the provider class
- Create `ldk/providers/cognito/user_store.py` with aiosqlite-backed user storage
- Schema: `users(username TEXT PK, password_hash TEXT, email TEXT, status TEXT, attributes JSON, created_at TEXT)`
- Parse `AWS::Cognito::UserPool` resources for `Policies.PasswordPolicy` and `Schema` (required attributes)
- Expose FastAPI routes matching the Cognito API surface

---

### Task P2-25: Sign-In and JWT Token Generation
**Sprint**: Phase 2 - Cognito Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cognito-provider (User Pool Operations)
**Depends on**: P2-24

**Description**: Implement user sign-in that verifies credentials and returns JWT tokens (ID token, access token, refresh token). Generate JWTs with claims matching the Cognito token structure, signed with a local RSA key pair. Expose a JWKS endpoint for token verification.

**Acceptance Criteria**:
- [ ] `InitiateAuth` API with `USER_PASSWORD_AUTH` flow verifies credentials and returns tokens
- [ ] ID token contains claims: `sub`, `email`, `email_verified`, `cognito:username`, `iss`, `aud`, `exp`, `iat`, `token_use: "id"`
- [ ] Access token contains claims: `sub`, `scope`, `client_id`, `iss`, `exp`, `iat`, `token_use: "access"`
- [ ] Refresh token is generated and stored for token refresh flow
- [ ] Tokens are signed with RS256 using a locally generated RSA key pair
- [ ] `/.well-known/jwks.json` endpoint returns the public key in JWKS format
- [ ] Invalid credentials return `NotAuthorizedException`
- [ ] Unconfirmed users return `UserNotConfirmedException`
- [ ] Unit tests verify token generation, claims content, and JWKS endpoint

**Technical Approach**:
- Generate an RSA key pair on provider startup (store in memory, regenerate each session)
- Use `PyJWT` library with `cryptography` backend for JWT signing
- Create `ldk/providers/cognito/token_service.py` for token generation
- Expose JWKS endpoint at `/.well-known/jwks.json` on the Cognito provider's HTTP routes
- Store refresh tokens in aiosqlite keyed by username

---

### Task P2-26: API Gateway Authorizer Integration
**Sprint**: Phase 2 - Cognito Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cognito-provider (API Gateway Authorizer Integration)
**Depends on**: P2-25

**Description**: Integrate the Cognito provider with the API Gateway provider to support Cognito authorizers on protected routes. Parse authorizer configuration from the cloud assembly. Validate JWT tokens on incoming requests to protected routes, reject invalid/missing tokens with 401.

**Acceptance Criteria**:
- [ ] `AWS::ApiGateway::Authorizer` resources with type `COGNITO_USER_POOLS` are parsed from cloud assembly
- [ ] Protected API routes validate the `Authorization` header for a valid JWT
- [ ] Token signature is verified using the local JWKS keys
- [ ] Token expiration is checked; expired tokens are rejected
- [ ] Token `iss` claim is verified against the expected user pool URL
- [ ] Valid token: decoded claims are passed to the Lambda handler in `event.requestContext.authorizer.claims`
- [ ] Missing token: 401 Unauthorized response
- [ ] Invalid/expired token: 401 Unauthorized response with error message
- [ ] Unit tests and integration test: protected route with valid/invalid/missing token

**Technical Approach**:
- Extend the API Gateway provider's request handling to check for authorizer configuration
- Create `ldk/providers/cognito/authorizer.py` with token validation logic
- Use `PyJWT` to decode and verify tokens against the local JWKS
- Parse `AWS::ApiGateway::Authorizer` and link to routes via `AuthorizerId` references in `AWS::ApiGateway::Method`

---

### Task P2-27: Lambda Triggers (Pre-Auth and Post-Confirmation)
**Sprint**: Phase 2 - Cognito Provider
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: cognito-provider (Lambda Triggers)
**Depends on**: P2-25

**Description**: Implement Cognito Lambda triggers: `PreAuthentication` and `PostConfirmation`. When configured in the CDK user pool, invoke the trigger Lambda handler at the appropriate point in the auth flow. The pre-auth trigger can deny authentication; the post-confirmation trigger receives user attributes after confirmation.

**Acceptance Criteria**:
- [ ] `PreAuthentication` trigger Lambda is invoked before credential verification during sign-in
- [ ] Pre-auth trigger receives the standard Cognito trigger event (triggerSource, request.userAttributes, userName)
- [ ] If pre-auth trigger throws an error, authentication is denied with the error message
- [ ] If pre-auth trigger returns successfully, authentication proceeds
- [ ] `PostConfirmation` trigger Lambda is invoked after user confirmation
- [ ] Post-confirmation trigger receives user attributes and confirmation details
- [ ] Trigger Lambda ARNs are parsed from `LambdaConfig` in the `AWS::Cognito::UserPool` resource
- [ ] Integration test: sign-in with pre-auth trigger that allows/denies; confirm with post-confirmation trigger

**Technical Approach**:
- Parse `LambdaConfig.PreAuthentication` and `LambdaConfig.PostConfirmation` from the user pool CloudFormation resource
- Resolve Lambda ARN references to local handler entries
- Construct Cognito trigger event payloads matching the AWS format
- Insert trigger invocations into the sign-up and sign-in flows in the provider

---

### Task P2-28: Cognito Cloud Assembly Parsing
**Sprint**: Phase 2 - Cognito Provider
**Estimate**: 1 day | **Points**: 2/5
**Specs**: cognito-provider (User Pool Operations, Lambda Triggers), cloud-assembly-parsing
**Depends on**: P2-24

**Description**: Extend the cloud assembly parser to extract Cognito resources: user pools (`AWS::Cognito::UserPool`), user pool clients (`AWS::Cognito::UserPoolClient`), and authorizer configurations. Extract password policy, required attributes, Lambda trigger configuration, and client settings.

**Acceptance Criteria**:
- [ ] Parser extracts `AWS::Cognito::UserPool` with `Policies.PasswordPolicy`, `Schema`, and `LambdaConfig`
- [ ] Parser extracts `AWS::Cognito::UserPoolClient` with `ClientId`, `ExplicitAuthFlows`, and `AllowedOAuthFlows`
- [ ] Parser extracts `AWS::ApiGateway::Authorizer` resources linked to Cognito user pools
- [ ] Lambda trigger ARN references are resolved to local handler entries
- [ ] Cognito nodes are added to the application graph with edges to Lambda triggers and API Gateway authorizers
- [ ] Unit tests with sample CloudFormation template containing Cognito resources

**Technical Approach**:
- Extend cloud assembly parser module for Cognito and Authorizer resource types
- Resolve `Fn::GetAtt` references between user pool, client, and authorizer resources
- Add user pool and client as nodes in the application graph

---

## 2.5: Validation Engine

### Task P2-29: Validation Engine Framework and Configurable Strictness
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: validation-engine (Configurable Strictness)
**Depends on**: Phase 1 complete

**Description**: Create the validation engine framework with a pluggable validator architecture and configurable strictness levels. Implement the two modes: warn (default, logs issues and continues) and strict (fails on validation errors). Validators register with the engine and are invoked at appropriate points.

**Acceptance Criteria**:
- [ ] Validation engine accepts registrations of validator plugins
- [ ] Each validator returns a list of `ValidationIssue` objects (level: warning/error, message, context)
- [ ] In warn mode, issues are logged as warnings and execution proceeds
- [ ] In strict mode, error-level issues cause the operation to fail with a validation error response
- [ ] Strictness is configurable via `ldk.yaml` configuration (`validation.strictness: warn | strict`)
- [ ] Per-validator strictness override is supported (e.g., `validation.permissions: strict, validation.schema: warn`)
- [ ] Validation results are formatted and displayed in terminal output
- [ ] Unit tests verify warn mode continues, strict mode blocks

**Technical Approach**:
- Create `ldk/validation/engine.py` with a `ValidationEngine` class
- Define `Validator` protocol/ABC with `validate(context) -> list[ValidationIssue]`
- Define `ValidationIssue` dataclass with `level`, `message`, `resource`, `operation` fields
- Read strictness configuration from the config system built in Phase 0/1
- Engine is called by providers before/after operations

---

### Task P2-30: Permission Validation
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 2 days | **Points**: 4/5
**Specs**: validation-engine (Permission Validation)
**Depends on**: P2-29

**Description**: Implement IAM permission validation that checks whether a handler has been granted access to a resource before allowing the operation. Use the permission boundaries extracted by the application graph (from CDK `grant*` methods) to validate `putItem`, `getItem`, `sendMessage`, etc. operations.

**Acceptance Criteria**:
- [ ] Permission validator checks if the calling handler has read/write permission on the target resource
- [ ] `grantRead` allows get/query/scan but not put/delete
- [ ] `grantWrite` allows put/delete but not get/query/scan (unless `grantReadWrite`)
- [ ] `grantReadWrite` allows all operations
- [ ] Unauthorized access in warn mode: logs warning with handler name, resource name, and operation
- [ ] Unauthorized access in strict mode: returns an access denied error to the handler
- [ ] Permission data is sourced from the application graph's permission boundary edges
- [ ] Unit tests: authorized access passes, unauthorized read/write detected, strict mode blocks

**Technical Approach**:
- Create `ldk/validation/permission_validator.py` implementing the `Validator` protocol
- Query the application graph for permission edges between the invoking handler and the target resource
- Map SDK operations to permission categories: `getItem/query/scan` -> read, `putItem/deleteItem/updateItem` -> write
- Hook into each provider's operation handling to invoke validation before executing the operation

---

### Task P2-31: DynamoDB Schema Validation
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: validation-engine (Schema Validation)
**Depends on**: P2-29

**Description**: Implement DynamoDB schema validation that checks whether data operations match the table's key schema. Validate that partition key and sort key values are present and have the correct types (S, N, B) as defined in the CDK table definition.

**Acceptance Criteria**:
- [ ] Validator checks that `putItem` operations include the partition key with the correct type
- [ ] Validator checks that sort key (if defined) is present with the correct type
- [ ] Type mismatch (e.g., numeric value for a string key) produces a validation issue
- [ ] Missing required key attributes produce a validation issue
- [ ] Validation issue includes: table name, expected key schema, actual values provided
- [ ] GSI/LSI key schemas are also validated on query operations
- [ ] Unit tests: correct key passes, wrong type detected, missing key detected

**Technical Approach**:
- Create `ldk/validation/schema_validator.py` implementing the `Validator` protocol
- Read table key schemas from the application graph (extracted from `AWS::DynamoDB::Table` resources)
- Hook into the DynamoDB provider's `putItem`, `updateItem`, `deleteItem` operations
- Compare provided key attribute types against the schema definition

---

### Task P2-32: Environment Variable Validation
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 1 day | **Points**: 2/5
**Specs**: validation-engine (Environment Variable Validation)
**Depends on**: P2-29

**Description**: Implement environment variable validation that checks whether environment variable references in handler configurations resolve to actual resources. Detect dangling references where a `Ref` or `Fn::GetAtt` points to a resource that doesn't exist or has been removed.

**Acceptance Criteria**:
- [ ] Validator runs at startup time (during environment initialization)
- [ ] Environment variables with `Ref` or `Fn::GetAtt` references to non-existent resources produce validation issues
- [ ] Validation issue includes: handler name, environment variable name, unresolvable reference
- [ ] Environment variables that resolve correctly are not flagged
- [ ] In strict mode, unresolvable references prevent the handler from starting
- [ ] Unit tests: valid reference passes, missing resource detected, removed resource detected

**Technical Approach**:
- Create `ldk/validation/env_var_validator.py` implementing the `Validator` protocol
- Run during cloud assembly processing, after all resources are parsed
- Check each Lambda function's environment variables for `Ref`/`Fn::GetAtt` targets
- Cross-reference against the set of known resources in the application graph

---

### Task P2-33: Event Shape Validation
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: validation-engine (Event Shape Validation)
**Depends on**: P2-29

**Description**: Implement event shape validation that checks whether events delivered to handlers match the expected shape for their trigger type. Define expected schemas for API Gateway proxy events, SQS events, S3 events, SNS events, EventBridge events, and Cognito trigger events.

**Acceptance Criteria**:
- [ ] API Gateway proxy events are validated for required fields: `httpMethod`, `path`, `headers`, `requestContext`
- [ ] SQS events are validated for: `Records[].messageId`, `Records[].body`, `Records[].eventSource`
- [ ] S3 events are validated for: `Records[].s3.bucket.name`, `Records[].s3.object.key`
- [ ] SNS events are validated for: `Records[].Sns.Message`, `Records[].Sns.TopicArn`
- [ ] EventBridge events are validated for: `source`, `detail-type`, `detail`, `id`, `time`
- [ ] Missing required fields produce validation issues with the field name and trigger type
- [ ] Event shape schemas are defined as JSON Schema or Pydantic models
- [ ] Unit tests: valid events pass, events with missing fields are flagged

**Technical Approach**:
- Create `ldk/validation/event_shape_validator.py` implementing the `Validator` protocol
- Define event schemas as Pydantic models (one per trigger type)
- Hook into each provider's invocation path to validate the constructed event before passing to the handler
- Use the application graph to determine the trigger type for each handler

---

### Task P2-34: Validation Engine Integration with Providers
**Sprint**: Phase 2 - Validation Engine
**Estimate**: 1.5 days | **Points**: 3/5
**Specs**: validation-engine (Permission Validation, Schema Validation, Event Shape Validation, Configurable Strictness)
**Depends on**: P2-30, P2-31, P2-32, P2-33

**Description**: Wire all validators into the existing provider operation paths. Add validation hooks to DynamoDB provider (schema + permission), SQS provider (permission), S3 provider (permission), Lambda runtime (event shape), and API Gateway (event shape). Ensure validation runs transparently without requiring provider code changes beyond hook points.

**Acceptance Criteria**:
- [ ] DynamoDB provider invokes schema and permission validators on each write operation
- [ ] SQS provider invokes permission validator on sendMessage/receiveMessage
- [ ] S3 provider invokes permission validator on putObject/getObject/deleteObject
- [ ] Lambda runtime invokes event shape validator before handler invocation
- [ ] API Gateway invokes event shape validator when constructing proxy events
- [ ] EventBridge provider invokes permission validator on putEvents
- [ ] Validation context includes the calling handler's identity (function name/ARN) for permission checks
- [ ] End-to-end integration test: handler writes to unauthorized table -> warning/error based on strictness

**Technical Approach**:
- Add a `validation_engine` parameter to provider constructors (dependency injection)
- Create a `validate_operation(handler_id, resource_id, operation, data)` method on the engine
- Insert validation calls at the beginning of each provider operation handler
- Pass the calling handler's identity through the SDK redirection layer (via request headers or context)

---

## Summary

| Sub-phase | Tasks | Total Points | Estimated Days |
|-----------|-------|-------------|----------------|
| 2.1 EventBridge Provider | P2-01 through P2-06 | 17/30 | 8.5 days |
| 2.2 Step Functions Provider | P2-07 through P2-17 | 30/55 | 15 days |
| 2.3 ECS Service Support | P2-18 through P2-23 | 15/30 | 7.5 days |
| 2.4 Cognito Provider | P2-24 through P2-28 | 14/25 | 7 days |
| 2.5 Validation Engine | P2-29 through P2-34 | 18/30 | 9 days |
| **Total** | **34 tasks** | **94/170** | **47 days** |

### Dependency Graph (Critical Paths)

**EventBridge**: P2-06 -> P2-01 -> P2-02 -> P2-03 -> P2-04, P2-05

**Step Functions**: P2-17 -> P2-07 -> P2-08 -> P2-09 -> P2-12; P2-08 -> P2-10, P2-11; P2-09 + P2-10 -> P2-13 -> P2-14; P2-08 -> P2-15 -> P2-16

**ECS**: P2-19 -> P2-18 -> P2-20 -> P2-21; P2-18 -> P2-22 -> P2-23

**Cognito**: P2-28 -> P2-24 -> P2-25 -> P2-26, P2-27

**Validation**: P2-29 -> P2-30, P2-31, P2-32, P2-33 -> P2-34

Sub-phases 2.1 through 2.4 can begin in parallel as they share no cross-dependencies until P2-34 (validation integration) which connects to all providers. Sub-phase 2.5 can begin its framework task (P2-29) in parallel and then validators (P2-30-33) can proceed alongside the providers, with the final integration task (P2-34) requiring all providers and validators to be complete.

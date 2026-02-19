# local-web-services Architecture

local-web-services is a local AWS emulator. It parses synthesized CloudFormation templates (CDK) or Terraform state and runs local emulations of AWS services so developers can build and test without deploying to AWS. It provides two CLIs: `ldk` (the server) and `lws` (an AWS CLI-compatible client).

## High-Level Overview

```
                          ldk dev
                            |
                     +------v------+
                     |    CLI      |  (Typer)
                     +------+------+
                            |
              +-------------+-------------+
              |                           |
      +-------v-------+          +-------v-------+
      | Config Loader |          | Mode Detect   |
      +-------+-------+          +-------+-------+
              |                     |           |
              |              +------v--+  +-----v------+
              |              |CDK Synth|  | Terraform  |
              |              +------+--+  +-----+------+
              |                     |           |
              +-------------+-------+-----------+
                            |
                    +-------v-------+
                    |   Assembly    |  Parses cdk.out/ or
                    |   Parser      |  Terraform state into AppModel
                    +-------+-------+
                            |
                    +-------v-------+
                    |  Graph        |  Builds dependency graph,
                    |  Builder      |  topological sort
                    +-------+-------+
                            |
                    +-------v-------+
                    |  Orchestrator |  Starts/stops providers
                    +-------+-------+   in dependency order
                            |
    +----+----+-------+-----+-----+-------+----+----+----+
    |    |    |       |     |     |       |    |    |    |
   API  Lam  Dyn    SQS   S3   SNS     EB  SFN  Cog  SSM  SM
   GW   bda  amo                              nito       /IAM
                                                         /STS
       Each provider runs as a FastAPI app
       on its own port (base, base+1, ...)

    +---------------------------------------------------+
    |  lws CLI (client)                                 |
    |  AWS CLI-style commands that talk to providers    |
    |  via /_ldk/ management API + wire protocols       |
    +---------------------------------------------------+
```

## Directory Structure

```
src/lws/
  cli/              CLI commands (Typer)
    ldk.py           ldk dev, ldk stop, ldk invoke, ldk reset (server)
    lws.py           lws CLI entry point (client)
    display.py       Rich terminal output helpers (banner, tables, summaries)
    services/        Per-service lws sub-commands
      client.py      LwsClient: discovery + wire protocol helpers
      dynamodb.py    lws dynamodb put-item, get-item, scan, query, ...
      sqs.py         lws sqs send-message, receive-message, ...
      s3.py          lws s3api put-object, get-object, ...
      sns.py         lws sns publish, list-topics, ...
      events.py      lws events put-events, ...
      stepfunctions  lws stepfunctions start-execution, ...
      cognito.py     lws cognito-idp sign-up, admin-get-user, ...
      ssm.py         lws ssm put-parameter, get-parameter, ...
      secretsmanager lws secretsmanager create-secret, get-secret-value, ...
      apigateway.py  lws apigateway get-rest-apis, ...
      iam_auth.py    lws iam-auth status/enable/disable/set/set-identity

  parser/            CDK CloudFormation parsing
    assembly.py      Top-level orchestrator, produces AppModel
    template_parser  Extracts resources from CloudFormation JSON
    tree_parser.py   Parses CDK tree.json
    asset_parser.py  Resolves Lambda code asset paths
    ref_resolver.py  Resolves Ref, GetAtt, Sub intrinsics

  providers/         AWS service emulations
    apigateway/      FastAPI-based HTTP gateway
    lambda_runtime/  Python and Node.js Lambda execution
    dynamodb/        SQLite-backed key-value store
    sqs/             In-memory queue with FIFO and DLQ support
    s3/              Filesystem-backed object store
    sns/             Pub/sub messaging with filter policies
    eventbridge/     Event pattern matching and routing
    stepfunctions/   Amazon States Language interpreter
    ecs/             Container process management
    cognito/         User pool, JWT token generation, and auth flows
    ssm/             Parameter Store (String, SecureString, StringList)
    secretsmanager/  Secrets storage and retrieval
    iam/             Stub IAM routes
    sts/             Stub STS routes (GetCallerIdentity)
    _shared/         Shared middleware and utilities
      aws_iam_auth.py        AwsIamAuthMiddleware + IamAuthConfig dataclasses
      iam_policy_engine.py   Pure-function IAM policy evaluation (Allow/Deny)
      iam_identity_store.py  Load identities from .lws/iam/identities.yaml
      iam_permissions_map.py Map operations to required IAM actions
      iam_resource_policies.py  Load resource policies from .lws/iam/resource_policies.yaml
      iam_default_permissions.yaml  Bundled operation-to-action defaults

  interfaces/        Abstract base classes
    provider.py      Provider lifecycle (start/stop/health_check)
    compute.py       ICompute for Lambda execution
    key_value_store  IKeyValueStore for DynamoDB
    queue.py         IQueue for SQS
    object_store.py  IObjectStore for S3
    event_bus.py     IEventBus for EventBridge
    state_machine.py IStateMachine for Step Functions

  runtime/           Lifecycle and orchestration
    orchestrator.py  Starts/stops providers in dependency order
    env_builder.py   Builds Lambda environment variables
    env_resolver.py  Resolves environment variable references
    lambda_context.py  Lambda context object for handler invocations
    sdk_env.py       Redirects AWS SDKs to local ports
    change_detector  Detects source changes for hot reload
    watcher.py       File watching for hot reload
    synth.py         CDK synth execution wrapper

  graph/             Dependency graph
    builder.py       Directed graph with topological sort

  config/            Configuration
    loader.py        Loads ldk.config.py or ldk.yaml

  terraform/         Terraform support
    detect.py        Detects CDK vs Terraform project type
    override.py      Generates Terraform endpoint override files
    gitignore.py     Manages .gitignore for generated override files

  api/               Management API
    management.py    /_ldk/ endpoints (invoke, status, reset, shutdown)
    gui.py           Web dashboard

  logging/           Observability
    logger.py        Structured logger with WebSocket streaming
    middleware.py    Request/response logging middleware
    tracer.py        Request tracing
    errors.py        Error formatting and reporting
    instrumentation  Metrics and telemetry

  validation/        Input validation
    engine.py        Validation orchestration
    schema_validator       Event payload validation
    event_shape_validator  Event structure validation
    env_var_validator      Environment variable validation
    permission_validator   IAM-like permission checks
    integration.py         Validation integration layer
```

## Core Concepts

### Provider

Every AWS service emulator implements the `Provider` abstract base class (`interfaces/provider.py`):

```python
class Provider(ABC):
    @property
    def name(self) -> str: ...
    async def start(self) -> None: ...
    async def stop(self) -> None: ...
    async def health_check(self) -> bool: ...
```

Providers that support persistence also implement `flush()` which the orchestrator calls before shutdown.

### AppModel

The parser layer produces an `AppModel` dataclass (`parser/assembly.py`) containing all discovered infrastructure: Lambda functions, DynamoDB tables, API routes, SQS queues, SNS topics, S3 buckets, EventBridge buses, Step Functions state machines, ECS services, Cognito user pools, SSM parameters, and secrets. This is the single data structure the rest of the system consumes.

### AppGraph

The graph builder (`graph/builder.py`) converts the `AppModel` into a directed graph of `Node` and `Edge` objects. Nodes have types (`NodeType` enum: `LAMBDA_FUNCTION`, `DYNAMODB_TABLE`, `API_GATEWAY`, etc.) and edges have types (`EdgeType` enum: `TRIGGER`, `DATA_DEPENDENCY`, `PERMISSION`, `EVENT_SOURCE`). Topological sort determines provider startup order.

### Orchestrator

The orchestrator (`runtime/orchestrator.py`) owns the full provider lifecycle:

1. Starts providers in topological order (dependencies first)
2. Health-checks each provider after start
3. Installs signal handlers for graceful shutdown (SIGINT/SIGTERM)
4. Exposes `request_shutdown()` for programmatic shutdown via the management API
5. On shutdown: flushes state, then stops providers in reverse order
6. A second signal forces immediate exit

### Project Modes

`ldk dev` supports two project modes, auto-detected or set via `--mode`:

- **CDK mode** — parses `cdk.out/` CloudFormation templates. Runs `cdk synth` if needed.
- **Terraform mode** — reads Terraform state to discover resources. Generates endpoint override files so Terraform providers route to local services.

Detection logic lives in `terraform/detect.py`.

### ldk CLI

The `ldk` command (`cli/ldk.py`) is the server-side CLI:

- `ldk dev` — starts the local development environment
- `ldk stop` — gracefully shuts down a running `ldk dev` instance via `POST /_ldk/shutdown`
- `ldk invoke` — directly invoke a Lambda function
- `ldk reset` — clear all provider state

### lws CLI

The `lws` command (`cli/lws.py`) is a separate CLI that acts as an AWS CLI-compatible client for a running `ldk dev` instance. Where `ldk dev` starts the server, `lws` talks to it.

`lws` uses service discovery via the `/_ldk/resources` management endpoint to find each provider's port, then speaks the provider's wire protocol directly:

- **JSON target dispatch** (`X-Amz-Target` header) for DynamoDB, SQS, SNS, Step Functions, EventBridge, Cognito, SSM, Secrets Manager
- **Form-encoded** requests for SQS (query-style API)
- **REST-style** requests for S3 and API Gateway

The shared `LwsClient` (`cli/services/client.py`) handles discovery and provides helpers for each protocol. Individual service modules (`cli/services/dynamodb.py`, `cli/services/sqs.py`, etc.) expose AWS CLI-style commands:

```
lws status                                         # provider health + ports
lws dynamodb put-item --table-name T --item '{}'   # DynamoDB operations
lws sqs send-message --queue-name Q --message-body '...'
lws s3api put-object --bucket B --key K --body '...'
lws stepfunctions start-execution --state-machine-arn ...
lws cognito-idp sign-up --user-pool-id ... --username ...
lws sns publish --topic-arn ... --message '...'
lws events put-events --entries '[...]'
lws ssm put-parameter --name /path --value V --type String
lws secretsmanager create-secret --name S --secret-string '...'
lws apigateway get-rest-apis
```

```
lws dynamodb scan --table-name Orders
     |
     v
LwsClient.discover()  -->  GET /_ldk/resources  -->  {dynamodb: {port: 3001}}
     |
     v
LwsClient.json_target_request("dynamodb", "DynamoDB_20120810.Scan", {...})
     |
     v
POST http://localhost:3001/   (X-Amz-Target: DynamoDB_20120810.Scan)
     |
     v
SqliteDynamoProvider handles request
```

## Middleware Chain

Each AWS service provider mounts middleware in this order (outermost first):

```
AwsOperationMockMiddleware   — intercept and return canned responses
AwsIamAuthMiddleware         — evaluate IAM identity/resource policies (enforce/audit/disabled)
AwsChaosMiddleware           — inject errors, latency, connection resets
RequestLoggingMiddleware     — capture method, path, status, duration
Route Handler
```

Middleware is added via `app.add_middleware()` in reverse order (Starlette applies them inside-out). IAM and STS providers are excluded from `AwsIamAuthMiddleware` to avoid bootstrap issues.

## Request Flow

```
HTTP request
     |
     v
API Gateway Provider (port 3000)
     |
     +---> RequestLoggingMiddleware (captures method, path, duration)
     |
     +---> Route matching (from parsed CDK routes)
     |
     v
Lambda Compute (PythonCompute or NodeJsCompute)
     |
     +---> Builds Lambda event from HTTP request
     +---> Resolves handler function
     +---> Executes handler with SDK env vars pointing to local ports
     |
     v
Handler may call other local services via AWS SDK:
     DynamoDB       ->  localhost:{base+1}  (SQLite)
     SQS            ->  localhost:{base+2}  (in-memory)
     S3             ->  localhost:{base+3}  (filesystem)
     SNS            ->  localhost:{base+4}  (in-memory)
     EventBridge    ->  localhost:{base+5}  (in-memory)
     Step Functions ->  localhost:{base+6}  (in-memory)
     Cognito        ->  localhost:{base+7}  (SQLite)
     SSM            ->  shared with management API
     Secrets Mgr    ->  shared with management API
```

## Port Allocation

Each service binds to a deterministic port offset from the configured base port (default 3000):

| Offset | Service          | Storage Backend  |
|--------|------------------|------------------|
| +0     | API Gateway      | -                |
| +1     | DynamoDB         | SQLite           |
| +2     | SQS              | In-memory        |
| +3     | S3               | Filesystem       |
| +4     | SNS              | In-memory        |
| +5     | EventBridge      | In-memory        |
| +6     | Step Functions   | In-memory        |
| +7     | Cognito          | SQLite           |

The management API (`/_ldk/`) is served on the same port as API Gateway. SSM, Secrets Manager, IAM, and STS share the management API port via route-based dispatch.

## SDK Redirection

`runtime/sdk_env.py` builds environment variables (`AWS_ENDPOINT_URL_DYNAMODB`, etc.) that the AWS SDKs respect. When Lambda handlers make SDK calls, traffic is automatically routed to the local providers instead of real AWS.

## Configuration

Configuration is resolved in priority order (highest wins):

1. CLI arguments (`--port`, `--log-level`, `--no-persist`, `--mode`)
2. Environment variables (`LDK_PORT`, `LDK_LOG_LEVEL`, etc.)
3. Config file (`ldk.config.py` or `ldk.yaml`)
4. Defaults

Key options: `port`, `persist`, `data_dir`, `log_level`, `cdk_out_dir`, `watch_include`, `watch_exclude`, `mode`, `iam_auth` (mode, default_identity, identity_header, per-service overrides).

## Startup Sequence

1. **CLI** parses arguments and loads configuration
2. **Config loader** merges CLI args, env vars, and config file
3. **Mode detection** determines CDK or Terraform mode (`terraform/detect.py`)
4. **CDK synth** runs if CDK mode and `cdk.out/` is missing or `--force-synth` is set
5. **Assembly parser** reads CloudFormation templates into `AppModel`
6. **Graph builder** creates dependency graph and topological order
7. **Provider creation** instantiates all service providers
8. **SDK env setup** configures AWS endpoint redirection
9. **Orchestrator** starts providers in dependency order, health-checks each
10. **File watcher** monitors source files for hot reload
11. **Management API** exposes `/_ldk/` endpoints (status, invoke, reset, shutdown) and web GUI

## Shutdown

Shutdown can be triggered three ways:

1. **Signal** — SIGINT (Ctrl+C) or SIGTERM
2. **API** — `POST /_ldk/shutdown` (used by `ldk stop`)
3. **CLI** — `ldk stop --port <port>`

All three invoke `orchestrator.request_shutdown()`, which flushes state and stops providers in reverse dependency order.

## Testing

```
tests/
  unit/           Fast, isolated tests per module
  integration/    Tests with multiple modules via the API layer
  e2e/            Full stack via ldk dev and the lws CLI
  architecture/   Architecture decision record tests
  fixtures/       Sample CDK applications for testing
```

| Command | What it runs |
|---------|-------------|
| `make test` | Unit + integration + architecture tests |
| `make test-e2e` | E2E tests (starts `ldk dev` automatically) |
| `make check` | Lint + format + complexity + tests |

See [TESTING.md](TESTING.md) for full testing standards, patterns, and examples.

## Key Dependencies

- **FastAPI** + **Uvicorn** - HTTP serving for all providers
- **Typer** - CLI framework
- **aiosqlite** - Async SQLite for DynamoDB and Cognito persistence
- **httpx** - Async HTTP client for service-to-service calls and `ldk stop`
- **PyJWT** - JWT generation for Cognito
- **watchdog** - Filesystem monitoring for hot reload
- **Rich** - Terminal output formatting
- **croniter** - Cron expression parsing for EventBridge schedules

## Design Patterns

- **Provider pattern** - Uniform lifecycle interface for all service emulators
- **Adapter pattern** - Each provider adapts AWS APIs to local storage (e.g., DynamoDB API to SQLite)
- **Strategy pattern** - Multiple compute backends (PythonCompute, NodeJsCompute, DockerCompute)
- **Graph-based orchestration** - Dependency graph with topological sort for startup ordering
- **Dependency injection** - Compute providers injected into API Gateway, SNS, EventBridge
- **Middleware pipeline** - RequestLoggingMiddleware wraps all service endpoints
- **Mode abstraction** - CDK and Terraform share the same AppModel, differing only in parsing

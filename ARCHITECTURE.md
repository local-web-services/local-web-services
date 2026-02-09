# local-web-services Architecture

local-web-services is a local AWS emulator for CDK applications. It parses synthesized CloudFormation templates from `cdk.out/` and runs local emulations of AWS services so developers can build and test without deploying to AWS. It provides two CLIs: `ldk` (the server) and `lws` (an AWS CLI-compatible client).

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
      | Config Loader |          |  CDK Synth    |
      +-------+-------+          +-------+-------+
              |                           |
              +-------------+-------------+
                            |
                    +-------v-------+
                    |   Assembly    |  Parses cdk.out/ into AppModel
                    |   Parser      |
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
          +---------+-------+-------+---------+
          |         |       |       |         |
       +--v--+   +--v--+ +-v-+  +--v--+  +---v---+
       | API |   | Lam |  |Dyn|  | SQS |  | more  |
       | GW  |   | bda |  |amo|  |     |  |  ...  |
       +-----+   +-----+  +---+  +-----+  +-------+
          :          :       :       :
          :   Each provider runs as a FastAPI app
          :   on its own port (base, base+1, ...)
          :
       +--+----------------------------------------------+
       |  lws CLI (client)                               |
       |  AWS CLI-style commands that talk to providers   |
       |  via /_ldk/ management API + wire protocols      |
       +-------------------------------------------------+
```

## Directory Structure

```
src/lws/
  cli/              CLI commands (Typer)
    main.py          ldk dev, ldk invoke, ldk reset (server)
    lws.py           lws CLI entry point (client)
    services/        Per-service lws sub-commands
      client.py      LwsClient: discovery + wire protocol helpers
      dynamodb.py    lws dynamodb put-item, get-item, scan, query, ...
      sqs.py         lws sqs send-message, receive-message, ...
      s3.py          lws s3api put-object, get-object, ...
      sns.py         lws sns publish, list-topics, ...
      events.py      lws events put-events, ...
      stepfunctions  lws stepfunctions start-execution, ...
      cognito.py     lws cognito-idp sign-up, admin-get-user, ...
      apigateway.py  lws apigateway get-rest-apis, ...

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
    sqs/             In-memory queue
    s3/              Filesystem-backed object store
    sns/             Pub/sub messaging
    eventbridge/     Event pattern matching and routing
    stepfunctions/   Amazon States Language interpreter
    ecs/             Container process management
    cognito/         User pool and JWT token generation

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
    sdk_env.py       Redirects AWS SDKs to local ports
    watcher.py       File watching for hot reload
    synth.py         CDK synth execution wrapper

  graph/             Dependency graph
    builder.py       Directed graph with topological sort

  config/            Configuration
    loader.py        Loads ldk.config.py or ldk.yaml

  api/               Management API
    management.py    /_ldk/ endpoints (invoke, status, reset)
    gui.py           Web dashboard

  logging/           Observability
    logger.py        Structured logger with WebSocket streaming
    middleware.py    Request/response logging middleware
    tracer.py        Request tracing

  validation/        Input validation
    engine.py        Validation orchestration
    schema_validator Event payload validation
    permission_validator  IAM-like permission checks
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

The parser layer produces an `AppModel` dataclass (`parser/assembly.py`) containing all discovered infrastructure: Lambda functions, DynamoDB tables, API routes, SQS queues, SNS topics, S3 buckets, EventBridge buses, Step Functions state machines, ECS services, and Cognito user pools. This is the single data structure the rest of the system consumes.

### AppGraph

The graph builder (`graph/builder.py`) converts the `AppModel` into a directed graph of `Node` and `Edge` objects. Nodes have types (`NodeType` enum: `LAMBDA_FUNCTION`, `DYNAMODB_TABLE`, `API_GATEWAY`, etc.) and edges have types (`EdgeType` enum: `TRIGGER`, `DATA_DEPENDENCY`, `PERMISSION`, `EVENT_SOURCE`). Topological sort determines provider startup order.

### Orchestrator

The orchestrator (`runtime/orchestrator.py`) owns the full provider lifecycle:

1. Starts providers in topological order (dependencies first)
2. Health-checks each provider after start
3. Installs signal handlers for graceful shutdown (SIGINT/SIGTERM)
4. On shutdown: flushes state, then stops providers in reverse order
5. A second signal forces immediate exit

### lws CLI

The `lws` command (`cli/lws.py`) is a separate CLI that acts as an AWS CLI-compatible client for a running `ldk dev` instance. Where `ldk dev` starts the server, `lws` talks to it.

`lws` uses service discovery via the `/_ldk/resources` management endpoint to find each provider's port, then speaks the provider's wire protocol directly:

- **JSON target dispatch** (`X-Amz-Target` header) for DynamoDB, SQS, SNS, Step Functions, EventBridge, Cognito
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
     DynamoDB  ->  localhost:{base+1}  (SQLite)
     SQS       ->  localhost:{base+2}  (in-memory)
     S3        ->  localhost:{base+3}  (filesystem)
     SNS       ->  localhost:{base+4}  (in-memory)
     EventBridge -> localhost:{base+5}
     Step Fn   ->  localhost:{base+6}
     Cognito   ->  localhost:{base+7}
```

## Port Allocation

Each service binds to a deterministic port offset from the configured base port (default 3000):

| Offset | Service        | Storage Backend  |
|--------|----------------|------------------|
| +0     | API Gateway    | -                |
| +1     | DynamoDB       | SQLite           |
| +2     | SQS            | In-memory        |
| +3     | S3             | Filesystem       |
| +4     | SNS            | In-memory        |
| +5     | EventBridge    | In-memory        |
| +6     | Step Functions | In-memory        |
| +7     | Cognito        | SQLite           |

The management API (`/_ldk/`) is served on the same port as API Gateway.

## SDK Redirection

`runtime/sdk_env.py` builds environment variables (`AWS_ENDPOINT_URL_DYNAMODB`, etc.) that the AWS SDKs respect. When Lambda handlers make SDK calls, traffic is automatically routed to the local providers instead of real AWS.

## Configuration

Configuration is resolved in priority order (highest wins):

1. CLI arguments (`--port`, `--log-level`, `--no-persist`)
2. Environment variables (`LDK_PORT`, `LDK_LOG_LEVEL`, etc.)
3. Config file (`ldk.config.py` or `ldk.yaml`)
4. Defaults

Key options: `port`, `persist`, `data_dir`, `log_level`, `cdk_out_dir`, `watch_include`, `watch_exclude`.

## Startup Sequence

1. **CLI** parses arguments and loads configuration
2. **Config loader** merges CLI args, env vars, and config file
3. **CDK synth** runs if `cdk.out/` is missing or `--force-synth` is set
4. **Assembly parser** reads CloudFormation templates into `AppModel`
5. **Graph builder** creates dependency graph and topological order
6. **Provider creation** instantiates all service providers
7. **SDK env setup** configures AWS endpoint redirection
8. **Orchestrator** starts providers in dependency order, health-checks each
9. **File watcher** monitors source files for hot reload
10. **Management API** exposes `/_ldk/` endpoints and web GUI

## Testing

```
tests/
  unit/           Fast, isolated tests per module
  integration/    End-to-end tests with multiple services
  architecture/   Architecture decision record tests
  fixtures/       Sample CDK applications for testing
```

Run with `make test` or `uv run pytest`.

## Key Dependencies

- **FastAPI** + **Uvicorn** - HTTP serving for all providers
- **Typer** - CLI framework
- **aiosqlite** - Async SQLite for DynamoDB and Cognito persistence
- **httpx** - Async HTTP client for service-to-service calls
- **PyJWT** - JWT generation for Cognito
- **watchdog** - Filesystem monitoring for hot reload
- **Rich** - Terminal output formatting
- **croniter** - Cron expression parsing for EventBridge schedules

## Design Patterns

- **Provider pattern** - Uniform lifecycle interface for all service emulators
- **Adapter pattern** - Each provider adapts AWS APIs to local storage (e.g., DynamoDB API to SQLite)
- **Strategy pattern** - Multiple compute backends (PythonCompute, NodeJsCompute)
- **Graph-based orchestration** - Dependency graph with topological sort for startup ordering
- **Dependency injection** - Compute providers injected into API Gateway, SNS, EventBridge
- **Middleware pipeline** - RequestLoggingMiddleware wraps all service endpoints

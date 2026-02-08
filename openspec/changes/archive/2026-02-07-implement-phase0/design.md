## Context
LDK is a greenfield Python project that reads CDK cloud assembly output and recreates the described application locally. Phase 0 proves the core architecture by implementing the minimum viable path: CDK assembly parsing, provider interfaces, a Node.js Lambda runtime, a SQLite-backed DynamoDB provider, an API Gateway HTTP server, SDK redirection, and the `ldk dev` CLI command with file watching.

The tech stack is defined by the project conventions: Python 3.11+, FastAPI, Typer, watchdog, aiosqlite, croniter, pytest. The package manager is `uv`.

## Goals / Non-Goals
- Goals:
  - Prove the end-to-end architecture: CDK synth -> parse -> graph -> providers -> SDK redirection -> invoke
  - Deliver a working `ldk dev` command for a simple CRUD app (API Gateway + Lambda + DynamoDB)
  - Establish patterns for provider interfaces, assembly parsing, and runtime invocation that scale to future phases
  - Node.js Lambda handler support (most common CDK runtime)
  - Basic hot reload for handler code changes

- Non-Goals:
  - Python/Java/.NET Lambda runtime support (future phases)
  - SQS, S3, EventBridge, Step Functions providers (future phases)
  - Production-grade error handling and edge cases
  - Performance optimization
  - DynamoDB Streams event source mapping
  - Automatic re-synth on CDK source changes (Phase 0 only notifies)

## Decisions

### Python Package Structure
- Decision: Use `src/` layout with a single `ldk` package containing sub-packages: `parser`, `graph`, `interfaces`, `providers`, `runtime`, `cli`, `config`
- Alternatives considered: Monorepo with separate packages (e.g., `ldk-core`, `ldk-interfaces`) -- deferred to later phases when interface package independence becomes necessary
- Rationale: Simplest structure for Phase 0; can be split later without breaking internal imports

### Cloud Assembly Parser Design
- Decision: Three-stage parsing pipeline: (1) `tree.json` for construct hierarchy, (2) CloudFormation templates for resource properties, (3) asset manifest for code locations. A top-level `parse_assembly()` orchestrator produces a normalized `AppModel` with typed dataclasses (`LambdaFunction`, `DynamoTable`, `ApiRoute`).
- Alternatives considered: Using CDK libraries directly to read the assembly -- rejected because it would require Node.js dependency and couple to CDK version
- Rationale: JSON-based parsing is language-agnostic and stable across CDK versions

### Provider Pattern
- Decision: Abstract base classes (Python `abc.ABC`) for all provider interfaces with lifecycle methods (`start`, `stop`, `health_check`). Provider implementations are concrete classes that extend the ABC and are instantiated by a factory based on resource type.
- Alternatives considered: Protocol-based (structural typing) -- rejected because ABCs provide clearer error messages when methods are missing
- Rationale: Explicit interface enforcement catches implementation errors at instantiation time

### SDK Redirection Approach
- Decision: Set `AWS_ENDPOINT_URL_*` environment variables in Lambda subprocess environments. No code changes to application handlers.
- Alternatives considered: Monkey-patching SDK clients, HTTP proxy -- both rejected as they require code changes or complex networking
- Rationale: Environment variable approach is the AWS-recommended way for custom endpoints, works across all SDK languages

### FastAPI Server Setup
- Decision: Single FastAPI application serves both the API Gateway routes (user-facing) and the DynamoDB wire protocol (SDK-facing) on separate ports. Uvicorn is used as the ASGI server, started programmatically via `uvicorn.Server` within the asyncio event loop.
- Alternatives considered: Using `aiohttp` or raw asyncio servers -- rejected because FastAPI provides automatic request parsing and OpenAPI docs for debugging
- Rationale: FastAPI is already in the tech stack and provides the right balance of features for both HTTP routing and API simulation

### Node.js Lambda Invocation
- Decision: Spawn a Node.js subprocess per invocation using a custom invoker script (`invoker.js`) that loads the handler module, calls the function, and returns the result via stdout. Environment variables (including SDK redirection) are passed via the subprocess environment.
- Alternatives considered: Persistent Node.js worker process with IPC -- deferred to later phases for performance
- Rationale: Subprocess-per-invocation is simplest, most debuggable, and matches Lambda's isolation model

### Application Graph
- Decision: Simple adjacency list representation with topological sort (Kahn's algorithm) for startup ordering. No external graph library.
- Alternatives considered: `networkx` library -- rejected as overkill for Phase 0
- Rationale: The graph operations needed (topological sort, cycle detection) are straightforward to implement

## Risks / Trade-offs
- Subprocess-per-invocation for Node.js handlers adds latency (~50-100ms cold start) -> Acceptable for Phase 0; warm process pool planned for later
- SQLite-based DynamoDB provider does not support all DynamoDB features (transactions, TTL, conditional expressions beyond basic comparisons) -> Sufficient for Phase 0 CRUD use cases
- Filter expressions evaluated in Python post-fetch rather than in SQL -> Performance concern only at scale, acceptable for local dev
- Single-process architecture means providers share the event loop -> Could cause blocking if a provider misbehaves; mitigated by running Node.js handlers as subprocesses

## Open Questions
- Should the DynamoDB HTTP server and API Gateway share a port or use separate ports? (Current decision: separate ports for isolation)
- Should we support both API Gateway REST API (v1) and HTTP API (v2) in Phase 0, or just one? (Current decision: both, as CDK commonly generates either)

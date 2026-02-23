## Context
Phase 1 builds upon the Phase 0 foundation to deliver a comprehensive local development environment. It spans multiple providers (SQS, S3, SNS), enhances the existing DynamoDB provider, adds Python Lambda support, and introduces developer experience features (logging, CLI, configuration). The work involves cross-cutting concerns such as resource discovery from CDK cloud assemblies, event dispatch between providers, and structured logging with trace propagation.

## Goals / Non-Goals
- Goals:
  - Python Lambda handlers execute via subprocess with full event/context serialization
  - SQS, S3, and SNS providers offer AWS SDK-compatible API endpoints
  - DynamoDB supports GSI, expressions, streams, batch operations, and eventual consistency
  - Structured logging provides request flow tracing with hierarchical output
  - CLI commands (`ldk invoke`, `ldk reset`) interact with the running environment
  - Configuration file (`ldk.yaml`) centralizes user-customizable settings
- Non-Goals:
  - Java and .NET handler runtimes (deferred to Phase 2+)
  - Production-grade providers (AWS-backed implementations)
  - Multi-region or cross-account simulation
  - CloudWatch Logs or Metrics providers
  - Step Functions or EventBridge providers

## Decisions

### Python Subprocess Runner Pattern
- Decision: Use `asyncio.create_subprocess_exec` to spawn a Python process per invocation with a bootstrap script that reads event from stdin and writes response to stdout
- Alternatives considered:
  - In-process execution via `importlib`: Rejected because Python handler code may have conflicting dependencies or global state; subprocess isolation is safer and matches AWS Lambda's execution model
  - Persistent subprocess pool: Deferred to a later optimization phase; per-invocation subprocess is simpler and adequate for local development throughput

### SQS In-Memory Queue with aiosqlite Persistence
- Decision: Use an in-memory data structure (`list` for visible messages, `dict` for in-flight) protected by `asyncio.Lock`, with aiosqlite for disk persistence on shutdown and periodic flush
- Alternatives considered:
  - Pure SQLite: Rejected due to latency overhead on every operation; in-memory is faster for the local development use case
  - Redis: Rejected as an unnecessary external dependency; the goal is zero external dependencies beyond Python and Node.js

### S3 Filesystem Storage Layout
- Decision: Store objects at `<data_dir>/s3/<bucket>/<key>` with metadata in sidecar JSON files at `<data_dir>/s3/.metadata/<bucket>/<key>.json`
- Alternatives considered:
  - SQLite blob storage: Rejected because filesystem storage allows developers to inspect/modify objects directly, which is valuable for debugging
  - Single metadata database: Rejected in favor of per-object sidecar files to avoid metadata corruption affecting all objects

### SNS Pub/Sub Dispatch
- Decision: In-memory topic registry with synchronous fan-out using `asyncio.gather` for parallel subscriber dispatch
- Alternatives considered:
  - Queue-based dispatch: Rejected as over-engineering for local use; direct async dispatch is simpler and has acceptable latency

### DynamoDB Expression Parser
- Decision: Implement a recursive descent parser for FilterExpression, UpdateExpression, and ConditionExpression that produces an AST evaluated against item attributes
- Alternatives considered:
  - Regex-based parsing: Rejected due to complexity of nested expressions, parentheses, and function calls
  - Third-party parser library (e.g., pyparsing): Rejected to minimize dependencies; the expression grammar is well-defined and manageable

### Structured Logging with Rich and contextvars
- Decision: Use Python's `logging` module with a custom formatter that uses `rich` for colored terminal output; propagate trace context via `contextvars.ContextVar` for hierarchical request tracing
- Alternatives considered:
  - structlog: Considered but Rich provides better terminal formatting out of the box
  - Print-based logging: Rejected; structured logging with levels is essential for developer experience

## Risks / Trade-offs
- Subprocess-per-invocation for Python has higher latency than in-process execution. Mitigation: acceptable for local dev; can add process pooling later
- In-memory SQS queue loses messages on crash (not graceful shutdown). Mitigation: aiosqlite periodic flush reduces the window; acceptable for local dev
- Eventual consistency simulation adds complexity to DynamoDB reads. Mitigation: configurable and can be disabled by setting delay to 0
- Expression parser is a significant implementation effort. Mitigation: implement incrementally, starting with common operators; defer edge cases

## Open Questions
- Should the Python bootstrap script support async handlers (`async def handler(event, context)`)?
- What is the optimal periodic flush interval for SQS persistence (currently on shutdown only)?
- Should CDK change detection support TypeScript CDK projects only, or also Python CDK?

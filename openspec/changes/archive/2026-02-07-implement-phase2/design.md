## Context
Phase 2 adds five major subsystems to LDK. Each subsystem introduces new provider implementations and integrates with the existing application graph, cloud assembly parser, and Lambda runtime from Phase 1. The design decisions here ensure consistency across providers, leverage the async-first architecture, and keep local development fast and transparent.

## Goals / Non-Goals
- Goals:
  - Faithful local emulation of EventBridge, Step Functions, ECS, and Cognito behavior for common CDK patterns
  - Fast feedback loops: validation catches errors at operation time, not after deployment
  - Pluggable validation architecture so new validators can be added without modifying the engine
  - All providers follow the established interface and lifecycle patterns from Phase 1
- Non-Goals:
  - Full AWS API compatibility (only the subset used by CDK-generated applications)
  - Docker-based ECS execution (local subprocesses are used instead)
  - OAuth/OIDC flows in Cognito (hybrid mode is recommended for advanced auth)
  - Production-grade ASL execution (local dev fidelity, not certification compliance)

## Decisions

### EventBridge Pattern Matcher
- **Decision**: Implement pattern matching as a pure function `match_event(pattern, event) -> bool` using recursive matching for nested detail fields.
- **Why**: Pure function design enables thorough unit testing of all pattern types (exact, prefix, numeric range, exists, anything-but) without provider infrastructure. Recursive matching naturally handles nested EventBridge patterns.
- **Alternatives considered**: Using a third-party rule engine library -- rejected because EventBridge pattern syntax is a small, well-defined grammar that is simpler to implement directly than to adapt a generic engine.

### EventBridge Scheduled Rules
- **Decision**: Use `croniter` for cron expression parsing and `asyncio.create_task` for the scheduling loop. AWS cron format `cron(...)` is converted to standard cron format for croniter. Rate expressions are converted to simple intervals.
- **Why**: croniter is a well-tested, lightweight library already in the project dependencies. asyncio tasks integrate naturally with the FastAPI event loop without threading complexity.
- **Alternatives considered**: APScheduler -- rejected as heavyweight for local dev; simple asyncio sleep loop is sufficient.

### ASL Execution Engine Architecture
- **Decision**: Implement a recursive state walker (`ExecutionEngine`) where each state type has an `execute` method returning the next state name and output. Use `asyncio.gather` for Parallel state concurrency and `asyncio.Semaphore` for Map state `MaxConcurrency` control.
- **Why**: Recursive walking maps directly to the ASL execution model (start at StartAt, follow Next transitions, terminate at End). asyncio concurrency gives true parallel branch execution without threads. The engine reuses itself for Parallel/Map sub-state-machines.
- **Alternatives considered**: Event-driven state machine with queues -- rejected because ASL execution is fundamentally sequential with limited concurrency points (Parallel/Map only), making a walker simpler and more debuggable.

### ECS Process Manager
- **Decision**: Use `asyncio.create_subprocess_exec` for process management with `asyncio.StreamReader` for stdout/stderr capture. Graceful restart uses SIGTERM with configurable grace period, escalating to SIGKILL.
- **Why**: asyncio subprocess management integrates with the existing event loop and allows non-blocking I/O streaming. SIGTERM/SIGKILL pattern matches production ECS task stopping behavior.
- **Alternatives considered**: Docker SDK for Python -- rejected because it adds heavy infrastructure requirements for local dev; subprocess execution is faster to start and simpler to debug.

### Cognito JWT Generation
- **Decision**: Use `PyJWT` with `cryptography` backend for RS256 JWT signing. Generate an ephemeral RSA key pair on provider startup. Expose `/.well-known/jwks.json` for token verification.
- **Why**: PyJWT is lightweight and well-supported. RS256 matches production Cognito token signing. Ephemeral keys avoid key management complexity in local dev. JWKS endpoint allows standard JWT verification by API Gateway authorizer integration.
- **Alternatives considered**: HS256 symmetric signing -- rejected because production Cognito uses RS256 and API Gateway authorizers expect to verify via JWKS; matching production signing ensures handler code that verifies tokens works locally without changes.

### Validation Engine Pluggable Architecture
- **Decision**: Define a `Validator` protocol/ABC with a `validate(context) -> list[ValidationIssue]` method. `ValidationIssue` is a dataclass with `level` (warning/error), `message`, `resource`, and `operation` fields. The engine iterates registered validators and applies strictness configuration to determine whether to warn or block.
- **Why**: Protocol/ABC pattern allows new validators to be added by implementing a single method. Dataclass-based issues provide structured, machine-readable results. Per-validator strictness overrides give fine-grained control.
- **Alternatives considered**: Decorator-based validation hooks on provider methods -- rejected because it couples validation to provider implementation and makes it harder to configure strictness globally.

## Risks / Trade-offs
- **Local ECS fidelity**: Running container commands as subprocesses may not replicate containerized behavior exactly (networking, filesystem isolation). Mitigation: Document differences and recommend Docker-based testing for container-specific concerns.
- **ASL coverage**: Not all ASL intrinsic functions and less-common features are implemented. Mitigation: Cover the states and features used by CDK-generated state machines; log warnings for unsupported features.
- **Croniter AWS cron format**: AWS cron uses 6 fields (with year) vs standard 5 fields. Mitigation: Convert AWS cron format to standard before passing to croniter; handle the `?` wildcard.
- **JWT token expiration in local dev**: Short-lived tokens may expire during debugging sessions. Mitigation: Use longer token lifetimes locally (1 hour default) and support token refresh.

## Open Questions
- Should the ECS provider support Fargate-specific features (ephemeral storage, task IAM roles) or treat all tasks uniformly as local processes?
- Should the Step Functions provider support intrinsic functions (`States.Format`, `States.JsonToString`, etc.) in Phase 2 or defer to a later phase?

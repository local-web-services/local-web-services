# Adding a New Emulated Service

This guide documents every step required to add a new AWS service emulator to
local-web-services. Follow the steps in order; each step references an existing
service you can use as a model.

The guide is intentionally prescriptive so that every new service looks the same.
When in doubt, look at how **Organizations** was added — it is the most recent
complete service addition and covers every layer.

---

## 0. Before you start

1. **Create an OpenSpec proposal** (`openspec/changes/add-<service>/`) before writing any
   implementation code. The proposal must be reviewed and approved before you proceed.
   See `openspec/AGENTS.md` for the full workflow.
2. **Check for name conflicts.** Search `openspec/specs/`, `openspec/changes/`, and
   `lang/python/core/src/lws/providers/` for any existing capability with the same name.
3. **Pick a port offset.** Check `lang/go/core/lws/server.go` (`ServiceOffsets` map) for all
   allocated offsets and choose the next unused integer. Document your chosen offset in the
   proposal's `design.md`.
4. **Determine the wire protocol.** Most AWS services use JSON target dispatch
   (`X-Amz-Target: <Service>_<Date>.<Action>`). A few (S3, API Gateway) use REST-style paths.
   Pick the protocol that matches the real AWS SDK behaviour for your service.

---

## 1. Formal specification (FizzBee)

**Location:** `lang/specification/core/formal/<service>/<service>.fizz`

**Reference:** `lang/specification/core/formal/organizations/organizations.fizz`

The FizzBee spec models the state machine of the service: which resources can exist,
what operations create/modify/delete them, and which invariants must always hold.

### 1.1 File header

```fizzbee
---
deadlock_detection: false
options:
  max_concurrent_actions: 1
  max_actions: <N>   # start with 10–15; increase if needed
---
# <ServiceName> Formal Specification
```

### 1.2 Constants (top level)

Declare fixed resource name sets at the top level — these are frozen constants.

```fizzbee
TRAIL_NAMES = ["trail-1", "trail-2"]
```

### 1.3 Mutable state (inside `action Init:`)

All mutable dicts/lists must be declared inside `action Init:` — top-level variables
are frozen and cannot be mutated.

```fizzbee
action Init:
    trail_status = {}   # trail_status[name] = "ACTIVE" | "DELETED"
    logging_enabled = {}  # logging_enabled[name] = True | False
```

### 1.4 Actions

- Annotate every action with `# step:`, `# result:`, and `# guard:` / `# guard_violation:`
  pairs — one pair per `if` condition. These annotations are parsed by
  `tools/fizz_to_gherkin.py` to generate Gherkin feature files.
- Use `oneof var in NAMES:` (not `any`; `any` is deprecated).
- Use flat dicts with compound keys instead of nested dicts (`trail+"#"+field`).
- Use sentinel values (`"DELETED"`, `False`) instead of `del`.
- No comments inside `oneof:` blocks.

See `lang/specification/core/formal/CLAUDE.md` for the complete syntax reference and
the list of critical constraints.

### 1.5 Assertions

Every meaningful invariant should be an `always assertion`. Examples:
- Resource status is always a member of the allowed set
- A deleted resource has no active dependents

### 1.6 Run the spec

```bash
fizz lang/specification/core/formal/<service>/<service>.fizz
```

Fix any compilation or model-checking failures before proceeding.

---

## 2. Gherkin informal specification

**Location:** `lang/specification/core/informal/<service>/`

**Reference:** `lang/specification/core/informal/organizations/`

Generate Gherkin from the formal spec:

```bash
python tools/fizz_to_gherkin.py lang/specification/core/formal/<service>/<service>.fizz
```

Save the output as `lang/specification/core/informal/<service>/sequences.feature`. Review
the generated scenarios and ensure they are human-readable. Do not hand-edit the file;
re-generate it if the formal spec changes.

---

## 3. Python provider

**Location:** `lang/python/core/src/lws/providers/<service>/`

**Reference:** `lang/python/core/src/lws/providers/organizations/`

### 3.1 State module `_<service>_state.py`

Define dataclasses for in-memory state:

```python
from dataclasses import dataclass, field
import time

@dataclass
class _Trail:
    name: str
    s3_bucket_name: str
    arn: str
    created: float = field(default_factory=time.time)

@dataclass
class _<Service>State:
    trails: dict[str, _Trail] = field(default_factory=dict)
```

Keep all state in plain Python dicts/lists — no external storage unless the service
explicitly requires persistence (DynamoDB and Cognito use SQLite; everything else is
in-memory).

### 3.2 Routes module `routes.py`

Structure:

```python
from fastapi import FastAPI, Request, Response

async def _handle_<action>(state, body) -> Response: ...

_ACTION_HANDLERS = {
    "CreateTrail": _handle_create_trail,
    ...
}

async def _<service>_dispatch(request, state) -> Response:
    target = request.headers.get("x-amz-target", "")
    body = await parse_json_body(request)
    action = resolve_api_action(target, body)
    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        return _error_response("InvalidAction", f"lws: {action} not implemented")
    return await handler(state, body)

def create_<service>_app(...) -> tuple[FastAPI, _<Service>State]:
    app = FastAPI(title="LDK <Service>")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="<service>")
    add_iam_auth_middleware(app, "<service>", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="<service>")
    state = state or _<Service>State()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _<service>_dispatch(request, state)

    return app, state
```

The middleware stack order (outermost → innermost):
`AwsOperationFakeMiddleware → AwsIamAuthMiddleware → AwsChaosMiddleware → RequestLoggingMiddleware → route handler`

See `lang/python/core/src/lws/providers/ssm/routes.py` for a complete implementation.

### 3.3 `__init__.py`

```python
from lws.providers.<service>.routes import create_<service>_app

__all__ = ["create_<service>_app"]
```

### 3.4 Register the provider

**File:** `lang/python/core/src/lws/cli/_ldk_providers_extended.py`

Add a `_register_<service>_provider` function following the same pattern as
`_register_organizations_provider`. Then call it from both:

- `lang/python/core/src/lws/cli/_ldk_server.py` (production path)
- `lang/python/core/src/lws/cli/_ldk_providers_extended.py` (extended-services path)

### 3.5 Port allocation in the server

**File:** `lang/python/core/src/lws/cli/_ldk_server.py`

Add the port constant following the existing pattern (e.g. `SSM_PORT = BASE_PORT + 12`).
Pass it through the provider registration and the `/_ldk/resources` response.

### 3.6 SDK endpoint redirection

**File:** `lang/python/core/src/lws/runtime/sdk_env.py`

If the service name does not map directly to its AWS SDK env-var suffix, add it to
`_SERVICE_ID_MAP`:

```python
_SERVICE_ID_MAP: dict[str, str] = {
    ...
    "cloudtrail": "CLOUDTRAIL",  # maps to AWS_ENDPOINT_URL_CLOUDTRAIL
}
```

Make sure the Lambda execution environment receives `AWS_ENDPOINT_URL_<SERVICE>` so SDK
calls from Lambda are redirected to the local provider.

### 3.7 lws CLI commands

**Location:** `lang/python/core/src/lws/cli/services/<service>.py`

Add a Typer app with AWS-CLI-style commands:

```python
import typer
from lws.cli.services.client import LwsClient

app = typer.Typer()

@app.command("describe-trails")
def describe_trails(): ...
```

Register the app in `lang/python/core/src/lws/cli/lws.py`:

```python
from lws.cli.services.<service> import app as <service>_app
lws.add_typer(<service>_app, name="<service>")
```

### 3.8 Python tests

| Layer | Location | What to test |
|---|---|---|
| Unit | `lang/python/core/tests/unit/providers/<service>/` | State module logic, action handlers |
| Integration | `lang/python/core/tests/integration/providers/<service>/` | HTTP wire protocol via ASGI transport |
| E2E | `lang/python/sdk/tests/e2e/<service>/` | Gherkin scenarios via pytest-bdd |

Every test file follows Arrange / Act / Assert with `# Arrange` / `# Act` / `# Assert`
comments. E2E tests use Gherkin feature files + pytest-bdd step definitions (`conftest.py`).

Run checks:

```bash
make -C lang/python/core check
make -C lang/python/sdk e2e-test
```

---

## 4. Go provider

**Location:** `lang/go/core/lws/providers/<service>/handler.go`

**Reference:** `lang/go/core/lws/providers/organizations/handler.go`

### 4.1 `handler.go`

Implement:
- `Store` struct with `sync.RWMutex` and `Reset()` method
- `NewHandler(state *ServerState) http.Handler` that dispatches on `X-Amz-Target`
- One `handle<Action>` function per operation

### 4.2 Register in `server.go`

**File:** `lang/go/core/lws/server.go`

```go
// ServiceOffsets
"<service>": 51,

// ServerPorts struct
<Service> int

// Ports()
<Service>: basePort + ServiceOffsets["<service>"],

// StartServer
<service>Mux := http.NewServeMux()
<service>Mux.Handle("/", <service>.NewHandler(state))
if err := srv.startService(<service>Mux, basePort+ServiceOffsets["<service>"]); err != nil {
    srv.Close()
    return nil, fmt.Errorf("<service> server: %w", err)
}
```

### 4.3 SDK session

**File:** `lang/go/sdk/lws/session.go`

Add the new port to the session's `Ports` struct and `aws.Config` builder so Go SDK tests
can target the local provider.

### 4.4 Go tests

Add a test file `lang/go/core/tests/<service>_test.go` with unit-level tests using the
Go standard test library. Wire Gherkin feature files in `lang/go/sdk/tests/bdd_test.go`:

```go
"../../../../lang/specification/core/informal/<service>/sequences.feature",
```

Run:

```bash
make -C lang/go check
```

---

## 5. TypeScript provider

**Location:** `lang/typescript/core/src/providers/<service>/index.ts`

**Reference:** `lang/typescript/core/src/providers/organizations/index.ts`

### 5.1 `index.ts`

Implement:
- In-memory state (plain objects/maps)
- `createHandler(): http.RequestListener` that dispatches on `X-Amz-Target`
- One handler function per action

### 5.2 Register in server

**File:** `lang/typescript/core/src/server.ts`

Add the offset constant and mount the handler:

```typescript
const SERVICE_OFFSETS: Record<string, number> = {
  ...
  cloudtrail: 51,
};
```

### 5.3 SDK session

**File:** `lang/typescript/sdk/lws/session.ts`

Add the new service port to the session so TypeScript tests can resolve the endpoint.

### 5.4 TypeScript tests

Follow the existing test patterns in `lang/typescript/core/` and
`lang/typescript/sdk/tests/`. Run:

```bash
make -C lang/typescript check
```

---

## 6. Java provider

**Location:** `lang/java/core/src/main/java/io/localwebservices/lws/providers/<ServiceName>/`

**Reference:** `lang/java/core/src/main/java/io/localwebservices/lws/providers/organizations/`

### 6.1 `<ServiceName>Store.java`

In-memory state store:

```java
public class CloudTrailStore {
    private final Map<String, Trail> trails = new HashMap<>();
    private final ReadWriteLock lock = new ReentrantReadWriteLock();

    public void reset() { ... }
}
```

### 6.2 `<ServiceName>Handler.java`

HTTP handler implementing `HttpHandler`:

```java
public class CloudTrailHandler implements HttpHandler {
    @Override
    public void handle(HttpExchange exchange) throws IOException {
        String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
        // dispatch ...
    }
}
```

### 6.3 Register in server

**File:** `lang/java/core/src/main/java/io/localwebservices/lws/LwsServer.java`

Add the port offset and mount the handler:

```java
private static final Map<String, Integer> SERVICE_OFFSETS = Map.of(
    ...
    "cloudtrail", 51
);
```

### 6.4 Java tests

Unit tests go in `lang/java/core/src/unitTest/java/.../providers/<ServiceName>/`.
BDD step definitions go in `lang/java/core/src/test/java/io/localwebservices/lws/steps/<ServiceName>Steps.java`.

Run:

```bash
make -C lang/java check
```

---

## 7. Checklist

Use this checklist when raising the implementation PR.

### Specification
- [ ] FizzBee spec created and passes `fizz`
- [ ] Gherkin feature file generated and saved
- [ ] OpenSpec proposal marked done (`openspec archive add-<service> --yes`)

### Python
- [ ] State dataclasses in `_<service>_state.py`
- [ ] Action handlers and dispatch in `routes.py`
- [ ] Provider registered in `_ldk_providers_extended.py` and `_ldk_server.py`
- [ ] `AWS_ENDPOINT_URL_<SERVICE>` added to `sdk_env.py`
- [ ] `lws <service>` CLI commands in `cli/services/<service>.py`
- [ ] CLI registered in `cli/lws.py`
- [ ] Unit tests pass (`make -C lang/python/core unit-test`)
- [ ] Integration tests pass (`make -C lang/python/core integration-test`)
- [ ] E2E Gherkin wired in `lang/python/sdk/tests/e2e/<service>/`
- [ ] `make -C lang/python check` passes

### Go
- [ ] `handler.go` with `Store` and `NewHandler`
- [ ] Registered in `server.go` at the chosen offset
- [ ] Port added to `ServerPorts` and `sdk_env`
- [ ] Unit tests in `tests/<service>_test.go`
- [ ] Gherkin path wired in `bdd_test.go`
- [ ] `make -C lang/go check` passes

### TypeScript
- [ ] `index.ts` with handler and in-memory state
- [ ] Registered in `server.ts`
- [ ] Port added to SDK session
- [ ] Tests pass
- [ ] `make -C lang/typescript check` passes

### Java
- [ ] `<ServiceName>Store.java` and `<ServiceName>Handler.java`
- [ ] Registered in `LwsServer.java`
- [ ] Unit tests and BDD step definitions
- [ ] `make -C lang/java check` passes

### Final
- [ ] `make check` at repo root passes across all languages
- [ ] `lws <service> <command>` works against a running `ldk dev` session
- [ ] `contributing/ADDING_A_SERVICE.md` updated if the process changed

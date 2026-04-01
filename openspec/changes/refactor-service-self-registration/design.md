# Design: Service Self-Registration and Provider Context

## Context

`inprocess.py` and `_ldk_providers_extended.py` are edited by every service-addition PR. Every `create_*_app` signature is edited by every cross-cutting-concern PR. Both conflict patterns are always trivially resolvable but always require manual rebase work.

## Hotspot Anatomy

### `inprocess.py` — three edit points per new service

```python
# 1. Import (inside _build_service_apps, alphabetical position)
from lws.providers.cloudformation.routes import create_cloudformation_app

# 2. _SERVICE_NAMES list
_SERVICE_NAMES = ["...", "cloudformation"]  # ← appended

# 3. App construction (appended at end of _build_service_apps)
service_apps.append(("cloudformation", create_cloudformation_app(...)))
```

### `_ldk_providers_extended.py` — one edit point per new service

```python
def _register_cloudformation_provider(...) -> None:  # ← new function appended
    ...
```

Plus a re-export in `_ldk_provider_factory.py`.

### `create_*_app` signatures — one edit point per cross-cutting concern, across 21 functions

```python
# CloudTrail PR touched all 21 of these:
def create_ssm_app(..., cloudtrail_provider: ICloudTrail | None = None) -> ...:
def create_dynamodb_app(..., cloudtrail_provider: ICloudTrail | None = None) -> ...:
# ... 19 more
```

---

## Design: `ServiceDescriptor`

### Decision: auto-discovery, not an explicit registry list

`service_descriptor.py` exposes a `discover_simple_services()` function that scans `lws.providers.*` subpackages for a `DESCRIPTOR` attribute on each `routes` module. Results are sorted alphabetically by service name for determinism.

```python
def discover_simple_services() -> list[ServiceDescriptor]:
    import importlib, pkgutil, lws.providers
    descriptors = []
    for _, mod_name, _ in pkgutil.iter_modules(lws.providers.__path__, "lws.providers."):
        mod = importlib.import_module(f"{mod_name}.routes")  # propagate ImportError loudly
        if (d := getattr(mod, "DESCRIPTOR", None)) is not None:
            descriptors.append(d)
    return sorted(descriptors, key=lambda d: d.name)
```

Import errors propagate rather than being swallowed — a broken `routes.py` is immediately visible at startup. Port assignment is dict-keyed by service name, so alphabetical ordering has no effect on port stability.

**Outcome**: adding a new simple service touches exactly one file — its own `routes.py`. Zero merge conflicts guaranteed for concurrent service-addition PRs.

### Decision: simple services only for the descriptor

Not all services can be described uniformly. SSM and Secrets Manager return state objects that are wired into StepFunctions. DynamoDB, EventBridge, and S3 take complex tracker refs and provider cross-references.

"Simple" services are those whose factory signature is `(chaos, aws_fake, context) -> (FastAPI, Any)`. Currently: `sts`, `cloudformation`, `service_catalog`, `organizations`. Auto-discovery means any future service that follows this pattern gets picked up automatically — no file outside `routes.py` needs to change.

Complex services remain unchanged. `DESCRIPTOR` is opt-in.

### Decision: `ServiceDescriptor` lives in `providers/_shared/`

Pure dataclass, no behaviour. Avoids circular imports with CLI code.

### Outcome

`_register_*` functions in `_ldk_providers_extended.py` are replaced by a single `_register_simple_providers` call to `discover_simple_services()`. `_build_service_apps` in `inprocess.py` likewise iterates the discovered list. Adding a new simple service requires no edits outside its own `routes.py`.

---

## Design: `ProviderContext`

### Problem

The `cloudtrail_provider` parameter was added to all 21 `create_*_app` signatures when CloudTrail was introduced. The next cross-cutting concern (e.g. metrics, distributed tracing, request ID propagation) will touch all 21 signatures again.

### Decision: single context object, keyword-only

```python
@dataclass
class ProviderContext:
    cloudtrail: ICloudTrail | None = None
    # Future fields added here without touching any factory signature
```

Each `create_*_app` signature changes from:

```python
def create_ssm_app(..., cloudtrail_provider: ICloudTrail | None = None):
    apply_cloudtrail_middleware(app, cloudtrail_provider, "ssm")
```

To:

```python
def create_ssm_app(..., context: ProviderContext | None = None):
    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "ssm")
```

Callers build one `ProviderContext` instance and pass it to all factory calls:

```python
ctx = ProviderContext(cloudtrail=_ct)
ssm_app, _ = create_ssm_app(..., context=ctx)
dynamodb_app = create_dynamodb_app(..., context=ctx)
```

### Decision: `ProviderContext` lives in `providers/_shared/`

Alongside `ServiceDescriptor`. No circular imports.

### Breaking change scope

This is a breaking change to all 21 `create_*_app` signatures. Any external code passing `cloudtrail_provider=` as a keyword argument will break. The `lws_testing` SDK is the primary caller; tests and example code are updated as part of this change.

---

## Sequencing

1. `ProviderContext` first — it simplifies the `ServiceDescriptor` factory signatures
2. `ServiceDescriptor` second — factories now accept `context: ProviderContext` uniformly
3. Discover skill update last — reflects both changes

The two can be implemented concurrently in separate worktrees as long as `ProviderContext` is merged before `ServiceDescriptor` factories are written.

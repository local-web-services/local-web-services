# Change: Refactor Service Self-Registration to Eliminate Merge Hotspots

## Problem

Every PR that adds a new AWS service to LWS must edit the same locations in the same files:

1. **`lang/python/sdk/src/lws_testing/_transport/inprocess.py`**
   - Add an import inside `_build_service_apps`
   - Add the service name to `_SERVICE_NAMES`
   - Append the service app in `_build_service_apps`

2. **`lang/python/core/src/lws/cli/_ldk_providers_extended.py`**
   - Add a `_register_<service>_provider` function
   - Re-export it from `_ldk_provider_factory.py`

3. **Every existing `create_*_app` signature (21 functions)**
   - Any PR that introduces a new cross-cutting concern (e.g. CloudTrail) must add a parameter to all 21 factory functions

When two service-addition PRs are open concurrently, all of these locations produce merge conflicts. The conflicts are always trivially resolvable ("keep both"), but they require manual intervention on every rebase.

## Proposed Solution

Two complementary changes:

### A. `ServiceDescriptor` — eliminate the append-point conflicts

Each service's `routes.py` exposes a `DESCRIPTOR` constant. The hotspot files discover and iterate descriptors rather than being hand-edited:

```python
# routes.py
DESCRIPTOR = ServiceDescriptor(
    name="cloudformation",
    factory=create_cloudformation_app,
)
```

`inprocess.py` and `_ldk_providers_extended.py` iterate a registry list — one edit point, not three.

### B. `ProviderContext` — eliminate the signature conflicts

Replace the `cloudtrail_provider: ICloudTrail | None = None` parameter that threads through all 21 `create_*_app` signatures with a single `ProviderContext` object:

```python
# Before (21 functions each carry this):
def create_ssm_app(..., cloudtrail_provider: ICloudTrail | None = None) -> ...:

# After:
def create_ssm_app(..., context: ProviderContext | None = None) -> ...:
```

Future cross-cutting concerns (metrics, distributed tracing, request ID propagation) add a field to `ProviderContext` rather than touching all 21 signatures.

## Affected Components

- `lang/python/core/src/lws/providers/_shared/service_descriptor.py` (new)
- `lang/python/core/src/lws/providers/_shared/provider_context.py` (new)
- `lang/python/core/src/lws/providers/*/routes.py` (expose DESCRIPTOR where applicable; replace `cloudtrail_provider` param with `context`)
- `lang/python/sdk/src/lws_testing/_transport/inprocess.py` (use descriptor registry; pass ProviderContext)
- `lang/python/core/src/lws/cli/_ldk_providers_extended.py` (use descriptor registry; pass ProviderContext)
- `lang/python/core/src/lws/cli/_ldk_provider_factory.py` (updated re-exports; pass ProviderContext)
- `.claude/skills/discover/SKILL.md` (updated hotspot guidance)

## Specs

- `service-descriptor` — defines the `ServiceDescriptor` protocol and the simple-service registry
- `provider-context` — defines `ProviderContext` and the migration of all `create_*_app` signatures
- `discover-skill-update` — updates the `/discover` skill to reflect both new patterns

# Tasks: Refactor Service Self-Registration

## Workstream A — ProviderContext (do first; unblocks B)

- [x] 1. Create `lang/python/core/src/lws/providers/_shared/provider_context.py` with `ProviderContext` dataclass (`cloudtrail: ICloudTrail | None = None`)
- [x] 2. Update all 21 `create_*_app` signatures: replace `cloudtrail_provider: ICloudTrail | None = None` with `context: ProviderContext | None = None`; update internal `apply_cloudtrail_middleware` calls to read `context.cloudtrail if context else None`
- [x] 3. Update `lang/python/sdk/src/lws_testing/_transport/inprocess.py`: build one `ProviderContext(cloudtrail=_ct)` and pass it to all factory calls
- [x] 4. Update `lang/python/core/src/lws/cli/_ldk_providers_extended.py` and `_ldk_provider_factory.py`: replace `cloudtrail_provider=` kwargs with `context=`
- [x] 5. Update all unit and integration tests that call `create_*_app` directly: replace `cloudtrail_provider=` with `context=ProviderContext(cloudtrail=...)`
- [x] 6. Run `make check` — verify all tests pass and no `cloudtrail_provider` keyword references remain

## Workstream B — ServiceDescriptor (requires A complete)

- [x] 7. Create `lang/python/core/src/lws/providers/_shared/service_descriptor.py` with `ServiceDescriptor` dataclass and `discover_simple_services()` function that scans `lws.providers.*` subpackages for `DESCRIPTOR` attributes, sorting results by name and propagating import errors
- [x] 8. Add `DESCRIPTOR` to `lang/python/core/src/lws/providers/sts/routes.py`
- [x] 9. Add `DESCRIPTOR` to `lang/python/core/src/lws/providers/cloudformation/routes.py`
- [x] 10. Add `DESCRIPTOR` to `lang/python/core/src/lws/providers/service_catalog/routes.py`
- [x] 11. Add `DESCRIPTOR` to `lang/python/core/src/lws/providers/organizations/routes.py`
- [x] 12. Update `inprocess.py`: call `discover_simple_services()` to derive `_SERVICE_NAMES` additions and `_build_service_apps` simple-service section; remove explicit per-service imports and appends for the four simple services
- [x] 13. Replace `_register_cloudformation_provider`, `_register_service_catalog_provider`, `_register_organizations_provider` in `_ldk_providers_extended.py` with a single `_register_simple_providers` that calls `discover_simple_services()`; update `_ldk_provider_factory.py` re-exports
- [x] 14. Add unit tests for `ServiceDescriptor` and `discover_simple_services()` — cover: all four descriptors found, non-DESCRIPTOR modules excluded, import errors propagate
- [x] 15. Run `make check` — verify all tests pass

## Workstream C — Discover skill (can run in parallel with B after A)

- [x] 17. Update `.claude/skills/discover/SKILL.md`: replace hotspot-file warnings with `ServiceDescriptor` and `ProviderContext` guidance as described in the `discover-skill-update` spec

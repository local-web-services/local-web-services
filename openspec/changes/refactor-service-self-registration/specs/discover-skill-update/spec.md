# Spec: Discover Skill Update

Updates the `/discover` skill to reflect the new `ServiceDescriptor` and `ProviderContext` patterns, replacing outdated hotspot-file guidance with accurate guidance for the post-refactor codebase.

Depends on: `service-descriptor`, `provider-context`.

## MODIFIED Requirements

### Requirement: Discover skill reflects ServiceDescriptor pattern for new services

The `/discover` skill's hotspot-file section SHALL be updated. For changes that add a new simple service, it MUST instruct the implementor to add a `DESCRIPTOR` to `routes.py` only — no other file needs editing. The skill MUST NOT reference `inprocess.py`, `_SERVICE_NAMES`, `_build_service_apps`, or `_ldk_providers_extended.py` as edit points for simple services.

#### Scenario: Discover run on a new simple service change
Given `/discover` run on a change that adds a new simple AWS service provider,
then the report states that adding a `DESCRIPTOR` to `routes.py` is sufficient and does not list `inprocess.py`, `_SERVICE_NAMES`, `_build_service_apps`, or `_ldk_providers_extended.py` as edit points.

### Requirement: Discover skill reflects ProviderContext pattern for cross-cutting concerns

The `/discover` skill's hotspot-file section SHALL be updated. For changes that add a new cross-cutting concern, it MUST instruct the implementor to add a field to `ProviderContext`, rather than describing 21 `create_*_app` signatures as edit points.

#### Scenario: Discover run on a new cross-cutting concern change
Given `/discover` run on a change that adds a new cross-cutting provider dependency,
then the report references `ProviderContext` as the single place to add the field and does not list individual `create_*_app` signatures as edit points.

# Spec: ServiceDescriptor

Introduces a `ServiceDescriptor` protocol so that simple services register themselves rather than requiring edits to `inprocess.py` and `_ldk_providers_extended.py`.

Depends on: `provider-context` (factories accept `context: ProviderContext`).

## ADDED Requirements

### Requirement: ServiceDescriptor dataclass

A `ServiceDescriptor` dataclass SHALL be available at `lws.providers._shared.service_descriptor`. It carries the service name and a factory callable that accepts `chaos`, `aws_fake`, and optional `context` keyword arguments and returns a `(FastAPI, Any)` tuple.

#### Scenario: ServiceDescriptor holds name and factory
Given `ServiceDescriptor(name="cloudformation", factory=create_cloudformation_app)`,
when `descriptor.name` is read,
then `"cloudformation"` is returned.

#### Scenario: ServiceDescriptor factory is callable with standard kwargs
Given a `ServiceDescriptor` for cloudformation,
when `descriptor.factory(chaos=None, aws_fake=None, context=None)` is called,
then a valid `(FastAPI, Any)` tuple is returned.

### Requirement: Simple service routes expose DESCRIPTOR

Each simple service's `routes.py` SHALL expose a module-level `DESCRIPTOR: ServiceDescriptor` constant. Simple services are those whose factory signature is `(chaos, aws_fake, context) -> (FastAPI, Any)`: `sts`, `cloudformation`, `service_catalog`, `organizations`.

#### Scenario: DESCRIPTOR is importable from a simple service routes module
Given `from lws.providers.cloudformation.routes import DESCRIPTOR`,
then `DESCRIPTOR.name == "cloudformation"`.

### Requirement: Auto-discovery of simple services

A `discover_simple_services()` function SHALL exist in `lws.providers._shared.service_descriptor`. It scans all `lws.providers.*` subpackages, imports each `routes` module, and collects any module that exposes a `DESCRIPTOR` attribute. Results MUST be returned sorted alphabetically by service name. Import errors MUST propagate rather than being silently suppressed.

#### Scenario: discover_simple_services returns all services with DESCRIPTOR
Given `sts`, `cloudformation`, `service_catalog`, and `organizations` routes modules each expose `DESCRIPTOR`,
when `discover_simple_services()` is called,
then all four descriptors are returned, sorted alphabetically by name.

#### Scenario: Routes module without DESCRIPTOR is not included
Given a routes module with no `DESCRIPTOR` attribute (e.g. `dynamodb/routes.py`),
when `discover_simple_services()` is called,
then that service is not included in the results.

#### Scenario: Import error in routes module propagates
Given a `routes.py` with a syntax or import error,
when `discover_simple_services()` is called,
then the error propagates immediately rather than silently skipping that service.

## MODIFIED Requirements

### Requirement: inprocess.py derives simple service names and apps from auto-discovery

`_SERVICE_NAMES` in `inprocess.py` SHALL be extended with names from `discover_simple_services()` rather than a hand-maintained list. `_build_service_apps` MUST iterate the discovered descriptors to build and append simple service apps rather than explicit per-service code.

#### Scenario: New simple service appears in _SERVICE_NAMES without editing inprocess.py
Given a new service's `routes.py` exposes `DESCRIPTOR`,
then its name automatically appears in `_SERVICE_NAMES` without any edit to `inprocess.py`.

#### Scenario: Simple service app is started in inprocess session
Given an `lws_testing` session started via `inprocess.py`,
when a boto3 client calls the cloudformation endpoint,
then the request is handled by the cloudformation app registered via the descriptor.

### Requirement: _ldk_providers_extended.py registers simple services via auto-discovery

The individual `_register_cloudformation_provider`, `_register_service_catalog_provider`, and `_register_organizations_provider` functions MUST be replaced by a single `_register_simple_providers` function that calls `discover_simple_services()` and iterates the results.

#### Scenario: ldk dev server registers simple services without per-service functions
Given the `ldk dev` server starting up,
then all simple services are registered and reachable without individual `_register_*` functions in `_ldk_providers_extended.py`.

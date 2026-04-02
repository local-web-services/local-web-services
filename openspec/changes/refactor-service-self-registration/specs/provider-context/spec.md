# Spec: ProviderContext

Replaces the `cloudtrail_provider` keyword argument on all `create_*_app` factory functions with a single `ProviderContext` object, so future cross-cutting concerns do not require touching every factory signature.

## ADDED Requirements

### Requirement: ProviderContext dataclass

A `ProviderContext` dataclass SHALL be available at `lws.providers._shared.provider_context`. It carries optional references to cross-cutting provider dependencies. Adding a new cross-cutting dependency requires adding one field to this class, not modifying any factory signature.

#### Scenario: ProviderContext carries cloudtrail reference
Given a `ProviderContext` with `cloudtrail` set to a provider instance,
when it is passed to `create_ssm_app(context=ctx)`,
then CloudTrail middleware is applied using that provider.

#### Scenario: ProviderContext defaults to None fields
Given `ProviderContext()` constructed with no arguments,
when it is passed to any `create_*_app`,
then no CloudTrail middleware is applied (same behaviour as before).

#### Scenario: Missing context is equivalent to empty context
Given `create_ssm_app` called without a `context` argument,
then behaviour is identical to passing `context=ProviderContext()`.

## MODIFIED Requirements

### Requirement: All create_*_app signatures accept context instead of cloudtrail_provider

All 21 `create_*_app` factory functions MUST replace:
```python
cloudtrail_provider: ICloudTrail | None = None
```
with:
```python
context: ProviderContext | None = None
```

The `cloudtrail_provider` keyword argument is removed. Callers must migrate to `context=ProviderContext(cloudtrail=...)`.

#### Scenario: Caller passes ProviderContext with cloudtrail
Given `ctx = ProviderContext(cloudtrail=my_cloudtrail_provider)`,
when `create_dynamodb_app(..., context=ctx)` is called,
then DynamoDB CloudTrail middleware uses `my_cloudtrail_provider`.

#### Scenario: Old cloudtrail_provider keyword raises TypeError
Given existing code calling `create_ssm_app(cloudtrail_provider=ct)`,
when that code runs after this change,
then Python raises `TypeError: unexpected keyword argument 'cloudtrail_provider'`.
(This is expected breakage; callers are updated as part of this change.)

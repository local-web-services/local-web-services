"""Resettable provider wrapper classes for in-process transport."""

from __future__ import annotations

from typing import Any


class _StubOrchestrator:
    """Minimal Orchestrator stub for the management API."""

    def __init__(self, providers: dict[str, Any]) -> None:
        self._providers = providers
        self._running = True

    @property
    def providers(self) -> dict[str, Any]:
        return self._providers

    @property
    def running(self) -> bool:
        return self._running

    def request_shutdown(self) -> None:
        self._running = False


class _LambdaRegistryProvider:
    """Thin wrapper that exposes LambdaRegistry as a resettable provider."""

    def __init__(self, registry: Any) -> None:
        self._registry = registry

    @property
    def name(self) -> str:
        return "lambda"

    async def reset(self) -> None:
        self._registry.reset()

    async def health_check(self) -> bool:
        return True


class _SsmStateProvider:
    """Thin wrapper that exposes _SsmState as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "ssm"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _SecretsManagerStateProvider:
    """Thin wrapper that exposes _SecretsState as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "secretsmanager"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _GlacierStateProvider:
    """Thin wrapper that exposes _GlacierState as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "glacier"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _S3TablesStateProvider:
    """Thin wrapper that exposes _S3TablesState as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "s3tables"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _ElasticsearchStateProvider:
    """Thin wrapper that exposes _SearchState for Elasticsearch as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "es"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _OpensearchStateProvider:
    """Thin wrapper that exposes _SearchState for OpenSearch as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "opensearch"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True


class _ApiGatewayStateProvider:
    """Thin wrapper that exposes ApiGatewayRouterBundle as a resettable provider."""

    def __init__(self, bundle: Any) -> None:
        self._bundle = bundle

    @property
    def name(self) -> str:
        return "apigateway"

    async def reset(self) -> None:
        self._bundle.reset()

    async def health_check(self) -> bool:
        return True


class _OrganizationsStateProvider:
    """Thin wrapper that exposes _OrganizationsState as a resettable provider."""

    def __init__(self, state: Any) -> None:
        self._state = state

    @property
    def name(self) -> str:
        return "organizations"

    async def reset(self) -> None:
        self._state.reset()

    async def health_check(self) -> bool:
        return True

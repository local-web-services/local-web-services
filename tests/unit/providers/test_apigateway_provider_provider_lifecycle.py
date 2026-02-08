"""Tests for API Gateway provider (P0-17)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult
from ldk.providers.apigateway.provider import (
    ApiGatewayProvider,
    RouteConfig,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a mock ICompute whose ``invoke`` resolves to the given payload/error."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


def _success_payload(
    status_code: int = 200,
    body: str = '{"ok": true}',
    headers: dict | None = None,
) -> dict:
    result: dict = {"statusCode": status_code, "body": body}
    if headers is not None:
        result["headers"] = headers
    return result


def _make_provider(
    routes: list[RouteConfig],
    compute_providers: dict[str, ICompute],
) -> ApiGatewayProvider:
    return ApiGatewayProvider(
        routes=routes,
        compute_providers=compute_providers,
        port=3000,
    )


def _client(provider: ApiGatewayProvider) -> httpx.AsyncClient:
    """Create an httpx.AsyncClient wired to the provider's ASGI app."""
    transport = httpx.ASGITransport(app=provider.app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ---------------------------------------------------------------------------
# Tests: GET request transforms to correct proxy event
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: POST request with JSON body
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: Path parameters extraction
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: Query string parameters extraction
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: Lambda response transforms to HTTP response
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: 500 response on Lambda invocation error
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: build_http_response helper directly
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: Provider lifecycle (name, health_check)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Tests: LambdaContext passed to compute
# ---------------------------------------------------------------------------


class TestProviderLifecycle:
    """Basic provider properties and health check."""

    def test_name(self) -> None:
        provider = _make_provider(routes=[], compute_providers={})
        assert provider.name == "api-gateway"

    @pytest.mark.asyncio
    async def test_health_check_before_start(self) -> None:
        provider = _make_provider(routes=[], compute_providers={})
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_health_check_after_start_and_stop(self) -> None:
        """Start and stop cycle without binding a real port (start sets RUNNING)."""
        provider = _make_provider(routes=[], compute_providers={})
        await provider.start()
        assert await provider.health_check() is True
        await provider.stop()
        assert await provider.health_check() is False

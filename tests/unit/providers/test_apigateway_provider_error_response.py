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


class TestErrorResponse:
    """When the Lambda invocation errors, a 500 response is returned."""

    @pytest.mark.asyncio
    async def test_invocation_error_returns_500(self) -> None:
        mock_compute = _make_compute_mock(error="RuntimeError: kaboom")
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/fail", handler_name="fail-fn")],
            compute_providers={"fail-fn": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/fail")

        assert response.status_code == 500
        body = response.json()
        assert body["error"] == "RuntimeError: kaboom"

"""Tests for API Gateway provider (P0-17)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.provider import (
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


class TestLambdaResponseTransform:
    """Lambda response with statusCode/headers/body maps to the HTTP response."""

    @pytest.mark.asyncio
    async def test_status_code_and_body_forwarded(self) -> None:
        payload = _success_payload(
            status_code=200,
            body='{"id": "123"}',
            headers={"Content-Type": "application/json"},
        )
        mock_compute = _make_compute_mock(payload=payload)
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/items/{id}", handler_name="get-item")],
            compute_providers={"get-item": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/items/123")

        # Assert
        expected_status = 200
        expected_body = {"id": "123"}
        expected_content_type = "application/json"
        assert response.status_code == expected_status
        assert response.json() == expected_body
        assert response.headers["content-type"] == expected_content_type

    @pytest.mark.asyncio
    async def test_custom_status_code(self) -> None:
        payload = _success_payload(status_code=204, body="")
        mock_compute = _make_compute_mock(payload=payload)
        provider = _make_provider(
            routes=[
                RouteConfig(method="DELETE", path="/items/{id}", handler_name="delete-item"),
            ],
            compute_providers={"delete-item": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.delete("/items/42")

        # Assert
        expected_status = 204
        assert response.status_code == expected_status

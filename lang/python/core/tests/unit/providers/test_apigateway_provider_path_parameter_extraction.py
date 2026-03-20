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


def _make_compute_fake(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a fake ICompute whose ``invoke`` resolves to the given payload/error."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


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


class TestPathParameterExtraction:
    """Path parameters from the URL are extracted into the proxy event."""

    @pytest.mark.asyncio
    async def test_path_parameters_are_extracted(self) -> None:
        fake_compute = _make_compute_fake(payload=_success_payload())
        provider = _make_provider(
            routes=[
                RouteConfig(method="GET", path="/orders/{order_id}", handler_name="get-order"),
            ],
            compute_providers={"get-order": fake_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/orders/abc-123")

        # Assert
        expected_status = 200
        expected_path_params = {"order_id": "abc-123"}
        expected_path = "/orders/abc-123"
        expected_resource = "/orders/{order_id}"
        assert response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {response.status_code!r}"
        )

        event: dict = fake_compute.invoke.call_args[0][0]
        actual_path_params = event["pathParameters"]
        actual_path = event["path"]
        actual_resource = event["resource"]
        assert actual_path_params == expected_path_params, (
            f"Expected {expected_path_params!r} but got {actual_path_params!r}"
        )
        assert actual_path == expected_path, f"Expected {expected_path!r} but got {actual_path!r}"
        assert actual_resource == expected_resource, (
            f"Expected {expected_resource!r} but got {actual_resource!r}"
        )

"""Tests for API Gateway provider (P0-17)."""

from __future__ import annotations

import json
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


class TestPostRequestWithBody:
    """POST request with a JSON body is transformed correctly."""

    @pytest.mark.asyncio
    async def test_post_request_with_json_body(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload(status_code=201))
        provider = _make_provider(
            routes=[RouteConfig(method="POST", path="/orders", handler_name="create-order")],
            compute_providers={"create-order": mock_compute},
        )

        body_dict = {"item": "widget", "qty": 3}

        async with _client(provider) as client:
            response = await client.post(
                "/orders",
                json=body_dict,
            )

        # Assert
        expected_status = 201
        expected_method = "POST"
        expected_path = "/orders"
        assert response.status_code == expected_status

        event: dict = mock_compute.invoke.call_args[0][0]
        actual_method = event["httpMethod"]
        actual_path = event["path"]
        assert actual_method == expected_method
        assert actual_path == expected_path

        # Body should be the JSON string
        parsed_body = json.loads(event["body"])
        assert parsed_body == body_dict
        assert event["isBase64Encoded"] is False

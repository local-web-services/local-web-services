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


class TestPostRequestWithBody:
    """POST request with a JSON body is transformed correctly."""

    @pytest.mark.asyncio
    async def test_post_request_with_json_body(self) -> None:
        fake_compute = _make_compute_fake(payload=_success_payload(status_code=201))
        provider = _make_provider(
            routes=[RouteConfig(method="POST", path="/orders", handler_name="create-order")],
            compute_providers={"create-order": fake_compute},
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
        assert response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {response.status_code!r}"
        )

        event: dict = fake_compute.invoke.call_args[0][0]
        actual_method = event["httpMethod"]
        actual_path = event["path"]
        assert actual_method == expected_method, (
            f"Expected {expected_method!r} but got {actual_method!r}"
        )
        assert actual_path == expected_path, f"Expected {expected_path!r} but got {actual_path!r}"

        # Body should be the JSON string
        parsed_body = json.loads(event["body"])
        assert parsed_body == body_dict, f"Expected {body_dict!r} but got {parsed_body!r}"
        assert event["isBase64Encoded"] is False, "Expected value to be truthy"

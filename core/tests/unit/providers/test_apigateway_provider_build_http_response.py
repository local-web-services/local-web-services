"""Tests for API Gateway provider (P0-17)."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

import httpx

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.provider import (
    ApiGatewayProvider,
    RouteConfig,
    build_http_response,
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


class TestBuildHttpResponse:
    """Unit tests for the build_http_response helper function."""

    def test_success_response(self) -> None:
        # Arrange
        expected_status = 200
        expected_body = b'{"data": 1}'
        expected_header_value = "value"
        result = InvocationResult(
            payload={
                "statusCode": expected_status,
                "headers": {"X-Custom": expected_header_value},
                "body": '{"data": 1}',
            },
            error=None,
            duration_ms=5.0,
            request_id="r1",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        assert resp.status_code == expected_status
        assert resp.body == expected_body
        actual_header_value = resp.headers["x-custom"]
        assert actual_header_value == expected_header_value

    def test_error_response(self) -> None:
        # Arrange
        expected_error = "timeout"
        result = InvocationResult(
            payload=None,
            error=expected_error,
            duration_ms=30000.0,
            request_id="r2",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        expected_status = 500
        assert resp.status_code == expected_status
        body = json.loads(resp.body)
        actual_error = body["error"]
        assert actual_error == expected_error

    def test_missing_payload_defaults(self) -> None:
        # Arrange
        result = InvocationResult(
            payload={},
            error=None,
            duration_ms=1.0,
            request_id="r3",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        expected_status = 200
        expected_body = b""
        assert resp.status_code == expected_status
        assert resp.body == expected_body

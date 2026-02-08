"""Tests for API Gateway provider (P0-17)."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult, LambdaContext
from ldk.providers.apigateway.provider import (
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


class TestGetRequestProxyEvent:
    """GET request is transformed into the expected API Gateway V1 proxy event."""

    @pytest.mark.asyncio
    async def test_get_request_transforms_to_proxy_event(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload())
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/items", handler_name="get-items")],
            compute_providers={"get-items": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/items")

        assert response.status_code == 200

        # Inspect the event passed to invoke
        call_args = mock_compute.invoke.call_args
        event: dict = call_args[0][0]

        assert event["httpMethod"] == "GET"
        assert event["path"] == "/items"
        assert event["body"] is None
        assert event["isBase64Encoded"] is False
        assert event["requestContext"]["httpMethod"] == "GET"
        assert event["requestContext"]["stage"] == "local"
        assert event["resource"] == "/items"


# ---------------------------------------------------------------------------
# Tests: POST request with JSON body
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

        assert response.status_code == 201

        event: dict = mock_compute.invoke.call_args[0][0]
        assert event["httpMethod"] == "POST"
        assert event["path"] == "/orders"

        # Body should be the JSON string
        parsed_body = json.loads(event["body"])
        assert parsed_body == body_dict
        assert event["isBase64Encoded"] is False


# ---------------------------------------------------------------------------
# Tests: Path parameters extraction
# ---------------------------------------------------------------------------


class TestPathParameterExtraction:
    """Path parameters from the URL are extracted into the proxy event."""

    @pytest.mark.asyncio
    async def test_path_parameters_are_extracted(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload())
        provider = _make_provider(
            routes=[
                RouteConfig(method="GET", path="/orders/{order_id}", handler_name="get-order"),
            ],
            compute_providers={"get-order": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/orders/abc-123")

        assert response.status_code == 200

        event: dict = mock_compute.invoke.call_args[0][0]
        assert event["pathParameters"] == {"order_id": "abc-123"}
        assert event["path"] == "/orders/abc-123"
        assert event["resource"] == "/orders/{order_id}"


# ---------------------------------------------------------------------------
# Tests: Query string parameters extraction
# ---------------------------------------------------------------------------


class TestQueryStringParameterExtraction:
    """Query string parameters are extracted into the proxy event."""

    @pytest.mark.asyncio
    async def test_query_string_parameters_extracted(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload())
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/search", handler_name="search")],
            compute_providers={"search": mock_compute},
        )

        async with _client(provider) as client:
            response = await client.get("/search?q=hello&page=2")

        assert response.status_code == 200

        event: dict = mock_compute.invoke.call_args[0][0]
        assert event["queryStringParameters"] == {"q": "hello", "page": "2"}

    @pytest.mark.asyncio
    async def test_no_query_string_gives_none(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload())
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/items", handler_name="list-items")],
            compute_providers={"list-items": mock_compute},
        )

        async with _client(provider) as client:
            await client.get("/items")

        event: dict = mock_compute.invoke.call_args[0][0]
        assert event["queryStringParameters"] is None


# ---------------------------------------------------------------------------
# Tests: Lambda response transforms to HTTP response
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

        assert response.status_code == 200
        assert response.json() == {"id": "123"}
        assert response.headers["content-type"] == "application/json"

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

        assert response.status_code == 204


# ---------------------------------------------------------------------------
# Tests: 500 response on Lambda invocation error
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


# ---------------------------------------------------------------------------
# Tests: build_http_response helper directly
# ---------------------------------------------------------------------------


class TestBuildHttpResponse:
    """Unit tests for the build_http_response helper function."""

    def test_success_response(self) -> None:
        result = InvocationResult(
            payload={
                "statusCode": 200,
                "headers": {"X-Custom": "value"},
                "body": '{"data": 1}',
            },
            error=None,
            duration_ms=5.0,
            request_id="r1",
        )
        resp = build_http_response(result)
        assert resp.status_code == 200
        assert resp.body == b'{"data": 1}'
        assert resp.headers["x-custom"] == "value"

    def test_error_response(self) -> None:
        result = InvocationResult(
            payload=None,
            error="timeout",
            duration_ms=30000.0,
            request_id="r2",
        )
        resp = build_http_response(result)
        assert resp.status_code == 500
        body = json.loads(resp.body)
        assert body["error"] == "timeout"

    def test_missing_payload_defaults(self) -> None:
        result = InvocationResult(
            payload={},
            error=None,
            duration_ms=1.0,
            request_id="r3",
        )
        resp = build_http_response(result)
        # Default status code is 200, body is empty string
        assert resp.status_code == 200
        assert resp.body == b""


# ---------------------------------------------------------------------------
# Tests: Provider lifecycle (name, health_check)
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


# ---------------------------------------------------------------------------
# Tests: LambdaContext passed to compute
# ---------------------------------------------------------------------------


class TestLambdaContextPassed:
    """Verify the LambdaContext passed to ICompute.invoke is well-formed."""

    @pytest.mark.asyncio
    async def test_lambda_context_fields(self) -> None:
        mock_compute = _make_compute_mock(payload=_success_payload())
        provider = _make_provider(
            routes=[RouteConfig(method="GET", path="/ctx", handler_name="ctx-fn")],
            compute_providers={"ctx-fn": mock_compute},
        )

        async with _client(provider) as client:
            await client.get("/ctx")

        context: LambdaContext = mock_compute.invoke.call_args[0][1]
        assert context.function_name == "ctx-fn"
        assert context.memory_limit_in_mb == 128
        assert context.timeout_seconds == 30
        assert context.aws_request_id  # non-empty string
        assert "ctx-fn" in context.invoked_function_arn

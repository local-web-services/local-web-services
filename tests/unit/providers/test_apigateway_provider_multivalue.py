"""Tests for API Gateway V1 multi-value headers and query string parameters."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

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
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload, error=error, duration_ms=1.0, request_id="test-req"
    )
    return mock


def _success_payload(
    status_code: int = 200,
    body: str = '{"ok": true}',
    headers: dict | None = None,
    multi_value_headers: dict | None = None,
) -> dict:
    result: dict = {"statusCode": status_code, "body": body}
    if headers is not None:
        result["headers"] = headers
    if multi_value_headers is not None:
        result["multiValueHeaders"] = multi_value_headers
    return result


def _make_provider(
    routes: list[RouteConfig],
    compute_providers: dict[str, ICompute],
) -> ApiGatewayProvider:
    return ApiGatewayProvider(routes=routes, compute_providers=compute_providers, port=3000)


def _client(provider: ApiGatewayProvider) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=provider.app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


class TestMultiValueHeaders:
    """V1 multi-value headers and query string parameters."""

    @pytest.mark.asyncio
    async def test_multi_value_headers_present_in_event(self) -> None:
        # Arrange
        compute = _make_compute_mock(_success_payload())
        route = RouteConfig(method="GET", path="/items", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.get("/items")

        # Assert
        event = compute.invoke.call_args[0][0]
        assert "multiValueHeaders" in event

    @pytest.mark.asyncio
    async def test_single_header_in_multi_value(self) -> None:
        # Arrange
        expected_key = "x-custom"
        expected_value = "value1"
        compute = _make_compute_mock(_success_payload())
        route = RouteConfig(method="GET", path="/items", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.get("/items", headers={expected_key: expected_value})

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_values = event["multiValueHeaders"][expected_key]
        assert actual_values == [expected_value]

    @pytest.mark.asyncio
    async def test_single_query_param_in_multi_value(self) -> None:
        # Arrange
        expected_key = "color"
        expected_value = "red"
        compute = _make_compute_mock(_success_payload())
        route = RouteConfig(method="GET", path="/items", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.get(f"/items?{expected_key}={expected_value}")

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_values = event["multiValueQueryStringParameters"][expected_key]
        assert actual_values == [expected_value]

    @pytest.mark.asyncio
    async def test_repeated_query_param_in_multi_value(self) -> None:
        # Arrange
        expected_key = "color"
        expected_values = ["red", "blue"]
        compute = _make_compute_mock(_success_payload())
        route = RouteConfig(method="GET", path="/items", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.get("/items?color=red&color=blue")

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_values = event["multiValueQueryStringParameters"][expected_key]
        assert actual_values == expected_values

    @pytest.mark.asyncio
    async def test_no_query_params_multi_value_is_none(self) -> None:
        # Arrange
        compute = _make_compute_mock(_success_payload())
        route = RouteConfig(method="GET", path="/items", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.get("/items")

        # Assert
        event = compute.invoke.call_args[0][0]
        assert event["multiValueQueryStringParameters"] is None

    def test_multi_value_response_headers(self) -> None:
        # Arrange
        expected_key = "x-custom"
        expected_values = ["val1", "val2"]
        result = InvocationResult(
            payload=_success_payload(multi_value_headers={expected_key: expected_values}),
            error=None,
            duration_ms=1.0,
            request_id="r1",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        actual_values = resp.headers.getlist(expected_key)
        assert expected_values[0] in actual_values
        assert expected_values[1] in actual_values

    def test_empty_multi_value_headers_in_response(self) -> None:
        # Arrange
        result = InvocationResult(
            payload=_success_payload(),
            error=None,
            duration_ms=1.0,
            request_id="r1",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status

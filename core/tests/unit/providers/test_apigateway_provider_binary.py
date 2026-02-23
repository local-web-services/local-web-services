"""Tests for API Gateway V1 binary payload encoding/decoding."""

from __future__ import annotations

import base64
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers._shared.request_helpers import is_binary_content_type
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


class TestBinaryPayloads:
    """V1 binary content type detection, request encoding, response decoding."""

    def test_octet_stream_is_binary(self) -> None:
        # Arrange
        content_type = "application/octet-stream"

        # Act
        actual = is_binary_content_type(content_type)

        # Assert
        assert actual is True

    def test_image_png_is_binary(self) -> None:
        # Arrange
        content_type = "image/png"

        # Act
        actual = is_binary_content_type(content_type)

        # Assert
        assert actual is True

    def test_audio_prefix_is_binary(self) -> None:
        # Arrange
        content_type = "audio/mpeg"

        # Act
        actual = is_binary_content_type(content_type)

        # Assert
        assert actual is True

    def test_json_is_not_binary(self) -> None:
        # Arrange
        content_type = "application/json"

        # Act
        actual = is_binary_content_type(content_type)

        # Assert
        assert actual is False

    def test_content_type_with_charset(self) -> None:
        # Arrange
        content_type = "image/png; charset=utf-8"

        # Act
        actual = is_binary_content_type(content_type)

        # Assert
        assert actual is True

    @pytest.mark.asyncio
    async def test_binary_body_is_base64_encoded(self) -> None:
        # Arrange
        expected_body = b"\x89PNG\r\n\x1a\n\x00\x00"
        expected_encoded = base64.b64encode(expected_body).decode("ascii")
        compute = _make_compute_mock({"statusCode": 200, "body": ""})
        route = RouteConfig(method="POST", path="/upload", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.post(
                "/upload",
                content=expected_body,
                headers={"content-type": "image/png"},
            )

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_body = event["body"]
        assert actual_body == expected_encoded
        assert event["isBase64Encoded"] is True

    @pytest.mark.asyncio
    async def test_text_body_is_not_encoded(self) -> None:
        # Arrange
        expected_body = '{"key": "value"}'
        compute = _make_compute_mock({"statusCode": 200, "body": ""})
        route = RouteConfig(method="POST", path="/data", handler_name="fn")
        provider = _make_provider([route], {"fn": compute})

        # Act
        async with _client(provider) as client:
            await client.post(
                "/data",
                content=expected_body.encode(),
                headers={"content-type": "application/json"},
            )

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_body = event["body"]
        assert actual_body == expected_body
        assert event["isBase64Encoded"] is False

    def test_base64_response_body_decoded(self) -> None:
        # Arrange
        expected_content = b"\x89PNG\r\n"
        encoded_body = base64.b64encode(expected_content).decode("ascii")
        result = InvocationResult(
            payload={
                "statusCode": 200,
                "body": encoded_body,
                "isBase64Encoded": True,
                "headers": {"content-type": "image/png"},
            },
            error=None,
            duration_ms=1.0,
            request_id="r1",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        actual_content = resp.body
        assert actual_content == expected_content

    def test_non_base64_response_body_unchanged(self) -> None:
        # Arrange
        expected_body = '{"data": 1}'
        result = InvocationResult(
            payload={"statusCode": 200, "body": expected_body, "isBase64Encoded": False},
            error=None,
            duration_ms=1.0,
            request_id="r2",
        )

        # Act
        resp = build_http_response(result)

        # Assert
        actual_body = resp.body.decode("utf-8")
        assert actual_body == expected_body

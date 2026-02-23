"""Tests for API Gateway V2 binary payload encoding/decoding."""

from __future__ import annotations

import base64
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

_FUNC_CONFIG = {"FunctionName": "test", "Runtime": "python3.11", "Handler": "index.handler"}


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload, error=error, duration_ms=1.0, request_id="test-req"
    )
    return mock


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


class TestV2BinaryPayloads:
    """V2 proxy binary request encoding and response decoding."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_binary_request_base64_encoded(self, client, registry) -> None:
        # Arrange
        binary_data = b"\x89PNG\r\n\x1a\n"
        expected_encoded = base64.b64encode(binary_data).decode("ascii")
        compute = _make_compute_mock({"statusCode": 200, "body": "{}"})
        registry.register("bin-func", {**_FUNC_CONFIG, "FunctionName": "bin-func"}, compute)

        api_resp = await client.post("/v2/apis", json={"name": "bin-api", "protocolType": "HTTP"})
        api_id = api_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:bin-func",
                "payloadFormatVersion": "2.0",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "POST /upload",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
        await client.post("/upload", content=binary_data, headers={"content-type": "image/png"})

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_body = event["body"]
        assert actual_body == expected_encoded
        assert event["isBase64Encoded"] is True

    @pytest.mark.asyncio
    async def test_text_request_not_encoded(self, client, registry) -> None:
        # Arrange
        expected_body = '{"key": "value"}'
        compute = _make_compute_mock({"statusCode": 200, "body": "{}"})
        registry.register("txt-func", {**_FUNC_CONFIG, "FunctionName": "txt-func"}, compute)

        api_resp = await client.post("/v2/apis", json={"name": "txt-api", "protocolType": "HTTP"})
        api_id = api_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:txt-func",
                "payloadFormatVersion": "2.0",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "POST /data",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
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

    @pytest.mark.asyncio
    async def test_base64_response_decoded(self, client, registry) -> None:
        # Arrange
        expected_content = b"\x89PNG\r\n"
        encoded_body = base64.b64encode(expected_content).decode("ascii")
        compute = _make_compute_mock(
            {
                "statusCode": 200,
                "body": encoded_body,
                "isBase64Encoded": True,
                "headers": {"content-type": "image/png"},
            }
        )
        registry.register("b64-func", {**_FUNC_CONFIG, "FunctionName": "b64-func"}, compute)

        api_resp = await client.post("/v2/apis", json={"name": "b64-api", "protocolType": "HTTP"})
        api_id = api_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:b64-func",
                "payloadFormatVersion": "2.0",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "$default",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
        resp = await client.get("/download")

        # Assert
        actual_content = resp.content
        assert actual_content == expected_content

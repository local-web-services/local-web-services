"""Tests for Lambda UpdateFunctionCode operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestUpdateFunctionCode:
    """Tests for PUT /2015-03-31/functions/{name}/code."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_function(self, client, name: str = "my-func") -> None:
        await client.post(
            "/2015-03-31/functions",
            json={
                "FunctionName": name,
                "Runtime": "nodejs18.x",
                "Handler": "index.handler",
                "Code": {},
            },
        )

    @pytest.mark.asyncio
    async def test_update_code_returns_config(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/code",
            json={"ZipFile": "base64data", "S3Bucket": "my-bucket", "S3Key": "code.zip"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["FunctionName"] == "my-func"
        assert data["FunctionArn"] == _FUNC_ARN
        assert data["Runtime"] == "nodejs18.x"

    @pytest.mark.asyncio
    async def test_update_code_with_empty_body(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/code",
            json={},
        )
        assert resp.status_code == 200
        assert resp.json()["FunctionName"] == "my-func"

    @pytest.mark.asyncio
    async def test_update_code_nonexistent_function_returns_404(self, client) -> None:
        resp = await client.put(
            "/2015-03-31/functions/nonexistent/code",
            json={"ZipFile": "base64data"},
        )
        assert resp.status_code == 404
        data = resp.json()
        assert data["Type"] == "ResourceNotFoundException"

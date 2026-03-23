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
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert (
            data["FunctionName"] == "my-func"
        ), f'Expected {"my-func"!r} but got {data["FunctionName"]!r}'
        assert (
            data["FunctionArn"] == _FUNC_ARN
        ), f'Expected {_FUNC_ARN!r} but got {data["FunctionArn"]!r}'
        assert (
            data["Runtime"] == "nodejs18.x"
        ), f'Expected {"nodejs18.x"!r} but got {data["Runtime"]!r}'

    @pytest.mark.asyncio
    async def test_update_code_with_empty_body(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/code",
            json={},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert (
            resp.json()["FunctionName"] == "my-func"
        ), f'Expected {"my-func"!r} but got {resp.json()["FunctionName"]!r}'

    @pytest.mark.asyncio
    async def test_update_code_nonexistent_function_returns_404(self, client) -> None:
        resp = await client.put(
            "/2015-03-31/functions/nonexistent/code",
            json={"ZipFile": "base64data"},
        )
        assert resp.status_code == 404, f"Expected {404!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["__type"] == "ResourceNotFoundException"

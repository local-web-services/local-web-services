"""Tests for Lambda UpdateFunctionConfiguration operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestUpdateFunctionConfiguration:
    """Tests for PUT /2015-03-31/functions/{name}/configuration."""

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
                "Role": "arn:aws:iam::000000000000:role/my-role",
                "Code": {},
            },
        )

    @pytest.mark.asyncio
    async def test_update_timeout(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Timeout": 30},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Timeout"] == 30, f'Expected {30!r} but got {data["Timeout"]!r}'
        assert data["FunctionName"] == "my-func", f'Expected {"my-func"!r} but got {data["FunctionName"]!r}'

    @pytest.mark.asyncio
    async def test_update_memory_size(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"MemorySize": 512},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json()["MemorySize"] == 512, f'Expected {512!r} but got {resp.json()["MemorySize"]!r}'

    @pytest.mark.asyncio
    async def test_update_handler(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Handler": "app.main"},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json()["Handler"] == "app.main", f'Expected {"app.main"!r} but got {resp.json()["Handler"]!r}'

    @pytest.mark.asyncio
    async def test_update_runtime(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Runtime": "python3.12"},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json()["Runtime"] == "python3.12", f'Expected {"python3.12"!r} but got {resp.json()["Runtime"]!r}'

    @pytest.mark.asyncio
    async def test_update_environment(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Environment": {"Variables": {"MY_VAR": "my_value"}}},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Environment"]["Variables"]["MY_VAR"] == "my_value", f'Expected {"my_value"!r} but got {data["Environment"]["Variables"]["MY_VAR"]!r}'

    @pytest.mark.asyncio
    async def test_update_multiple_fields(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={
                "Timeout": 60,
                "MemorySize": 1024,
                "Handler": "new_handler.run",
            },
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Timeout"] == 60, f'Expected {60!r} but got {data["Timeout"]!r}'
        assert data["MemorySize"] == 1024, f'Expected {1024!r} but got {data["MemorySize"]!r}'
        assert data["Handler"] == "new_handler.run", f'Expected {"new_handler.run"!r} but got {data["Handler"]!r}'

    @pytest.mark.asyncio
    async def test_update_preserves_unchanged_fields(self, client) -> None:
        await self._create_function(client)

        resp = await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Timeout": 30},
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        # Original values should remain
        assert data["Handler"] == "index.handler", f'Expected {"index.handler"!r} but got {data["Handler"]!r}'
        assert data["Runtime"] == "nodejs18.x", f'Expected {"nodejs18.x"!r} but got {data["Runtime"]!r}'
        assert data["MemorySize"] == 128, f'Expected {128!r} but got {data["MemorySize"]!r}'

    @pytest.mark.asyncio
    async def test_update_nonexistent_function_returns_404(self, client) -> None:
        resp = await client.put(
            "/2015-03-31/functions/nonexistent/configuration",
            json={"Timeout": 30},
        )
        assert resp.status_code == 404, f"Expected {404!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Type"] == "ResourceNotFoundException", f'Expected {"ResourceNotFoundException"!r} but got {data["Type"]!r}'

    @pytest.mark.asyncio
    async def test_update_persists_in_registry(self, client, registry) -> None:
        await self._create_function(client)

        await client.put(
            "/2015-03-31/functions/my-func/configuration",
            json={"Timeout": 45},
        )

        config = registry.get_config("my-func")
        assert config is not None, "Expected value to be set but was None"
        assert config["Timeout"] == 45, f'Expected {45!r} but got {config["Timeout"]!r}'

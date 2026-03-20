"""Tests for Lambda management routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    _resolve_code_path_from_name,
    create_lambda_management_app,
)


class TestLambdaManagementRoutes:
    """Test Lambda management HTTP API."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_create_function(self, client) -> None:
        resp = await client.post(
            "/2015-03-31/functions",
            json={
                "FunctionName": "my-func",
                "Runtime": "nodejs18.x",
                "Handler": "index.handler",
                "Role": "arn:aws:iam::000000000000:role/my-role",
                "Code": {},
            },
        )
        assert resp.status_code == 201, f"Expected {201!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["FunctionName"] == "my-func", (
            f'Expected {"my-func"!r} but got {data["FunctionName"]!r}'
        )
        assert data["Runtime"] == "nodejs18.x", (
            f'Expected {"nodejs18.x"!r} but got {data["Runtime"]!r}'
        )
        assert "FunctionArn" in data, f'Expected {"FunctionArn"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_get_function(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.get("/2015-03-31/functions/my-func")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Configuration"]["FunctionName"] == "my-func", (
            f'Expected {"my-func"!r} but got {data["Configuration"]["FunctionName"]!r}'
        )

    @pytest.mark.asyncio
    async def test_get_function_not_found(self, client) -> None:
        resp = await client.get("/2015-03-31/functions/nonexistent")
        assert resp.status_code == 404, f"Expected {404!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_list_functions(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "func-a", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "func-b", "Runtime": "python3.12", "Handler": "handler.main"},
        )

        resp = await client.get("/2015-03-31/functions")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert len(data["Functions"]) == 2, f'Expected {2!r} but got {len(data["Functions"])!r}'

    @pytest.mark.asyncio
    async def test_delete_function(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.delete("/2015-03-31/functions/my-func")
        assert resp.status_code == 204, f"Expected {204!r} but got {resp.status_code!r}"

        get_resp = await client.get("/2015-03-31/functions/my-func")
        assert get_resp.status_code == 404, f"Expected {404!r} but got {get_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_add_permission_stub(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.post(
            "/2015-03-31/functions/my-func/policy",
            json={"StatementId": "sid-1", "Action": "lambda:InvokeFunction", "Principal": "*"},
        )
        assert resp.status_code == 201, f"Expected {201!r} but got {resp.status_code!r}"
        assert "Statement" in resp.json(), f'Expected {"Statement"!r} to be in {resp.json()!r}'

    @pytest.mark.asyncio
    async def test_get_policy_stub(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.get("/2015-03-31/functions/my-func/policy")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert "Policy" in resp.json(), f'Expected {"Policy"!r} to be in {resp.json()!r}'

    @pytest.mark.asyncio
    async def test_event_source_mapping_lifecycle(self, client) -> None:
        resp = await client.post(
            "/2015-03-31/event-source-mappings",
            json={
                "EventSourceArn": "arn:aws:sqs:us-east-1:000:my-queue",
                "FunctionName": "my-func",
            },
        )
        assert resp.status_code == 202, f"Expected {202!r} but got {resp.status_code!r}"
        esm_uuid = resp.json()["UUID"]

        get_resp = await client.get(f"/2015-03-31/event-source-mappings/{esm_uuid}")
        assert get_resp.status_code == 200, f"Expected {200!r} but got {get_resp.status_code!r}"

        del_resp = await client.delete(f"/2015-03-31/event-source-mappings/{esm_uuid}")
        assert del_resp.status_code == 202, f"Expected {202!r} but got {del_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_list_tags_stub(self, client) -> None:
        resp = await client.get(
            "/2015-03-31/tags/arn:aws:lambda:us-east-1:000000000000:function:my-func"
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json() == {"Tags": {}}, (
            "Expected {!r} but got {!r}".format({"Tags": {}}, resp.json())
        )

    @pytest.mark.asyncio
    async def test_unknown_path_returns_not_found(self, client) -> None:
        resp = await client.get("/some/unknown/path")
        assert resp.status_code == 404, f"Expected {404!r} but got {resp.status_code!r}"
        body = resp.json()
        assert "lws" in body["Message"], f'Expected {"lws"!r} to be in {body["Message"]!r}'
        assert "Lambda" in body["Message"], f'Expected {"Lambda"!r} to be in {body["Message"]!r}'

    @pytest.mark.asyncio
    async def test_registry_stores_compute(self, registry) -> None:
        """Verify that CreateFunction populates the shared registry."""
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
            await client.post(
                "/2015-03-31/functions",
                json={
                    "FunctionName": "test-func",
                    "Runtime": "nodejs18.x",
                    "Handler": "index.handler",
                },
            )

        assert registry.get_config("test-func") is not None, "Expected value to be set but was None"
        assert registry.get_compute("test-func") is not None, (
            "Expected value to be set but was None"
        )

    @pytest.mark.asyncio
    async def test_resolve_code_path_from_name_kebab(self, tmp_path) -> None:
        """PascalCase function name resolves to kebab-case directory."""
        (tmp_path / "lambda" / "create-order").mkdir(parents=True)
        result = _resolve_code_path_from_name("CreateOrderFunction", tmp_path)
        assert result == tmp_path / "lambda" / "create-order", (
            f'Expected {tmp_path / "lambda" / "create-order"!r} but got {result!r}'
        )

    @pytest.mark.asyncio
    async def test_resolve_code_path_from_name_not_found(self, tmp_path) -> None:
        """Returns None when no matching directory exists."""
        (tmp_path / "lambda").mkdir(parents=True)
        result = _resolve_code_path_from_name("UnknownFunction", tmp_path)
        assert result is None, f"Expected None but got {result!r}"

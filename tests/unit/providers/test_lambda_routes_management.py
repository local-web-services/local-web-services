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
        assert resp.status_code == 201
        data = resp.json()
        assert data["FunctionName"] == "my-func"
        assert data["Runtime"] == "nodejs18.x"
        assert "FunctionArn" in data

    @pytest.mark.asyncio
    async def test_get_function(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.get("/2015-03-31/functions/my-func")
        assert resp.status_code == 200
        data = resp.json()
        assert data["Configuration"]["FunctionName"] == "my-func"

    @pytest.mark.asyncio
    async def test_get_function_not_found(self, client) -> None:
        resp = await client.get("/2015-03-31/functions/nonexistent")
        assert resp.status_code == 404

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
        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Functions"]) == 2

    @pytest.mark.asyncio
    async def test_delete_function(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.delete("/2015-03-31/functions/my-func")
        assert resp.status_code == 204

        get_resp = await client.get("/2015-03-31/functions/my-func")
        assert get_resp.status_code == 404

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
        assert resp.status_code == 201
        assert "Statement" in resp.json()

    @pytest.mark.asyncio
    async def test_get_policy_stub(self, client) -> None:
        await client.post(
            "/2015-03-31/functions",
            json={"FunctionName": "my-func", "Runtime": "nodejs18.x", "Handler": "index.handler"},
        )

        resp = await client.get("/2015-03-31/functions/my-func/policy")
        assert resp.status_code == 200
        assert "Policy" in resp.json()

    @pytest.mark.asyncio
    async def test_event_source_mapping_lifecycle(self, client) -> None:
        resp = await client.post(
            "/2015-03-31/event-source-mappings",
            json={
                "EventSourceArn": "arn:aws:sqs:us-east-1:000:my-queue",
                "FunctionName": "my-func",
            },
        )
        assert resp.status_code == 202
        esm_uuid = resp.json()["UUID"]

        get_resp = await client.get(f"/2015-03-31/event-source-mappings/{esm_uuid}")
        assert get_resp.status_code == 200

        del_resp = await client.delete(f"/2015-03-31/event-source-mappings/{esm_uuid}")
        assert del_resp.status_code == 202

    @pytest.mark.asyncio
    async def test_list_tags_stub(self, client) -> None:
        resp = await client.get(
            "/2015-03-31/tags/arn:aws:lambda:us-east-1:000000000000:function:my-func"
        )
        assert resp.status_code == 200
        assert resp.json() == {"Tags": {}}

    @pytest.mark.asyncio
    async def test_unknown_path_returns_not_found(self, client) -> None:
        resp = await client.get("/some/unknown/path")
        assert resp.status_code == 404
        body = resp.json()
        assert "lws" in body["Message"]
        assert "Lambda" in body["Message"]

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

        assert registry.get_config("test-func") is not None
        assert registry.get_compute("test-func") is not None

    @pytest.mark.asyncio
    async def test_resolve_code_path_from_name_kebab(self, tmp_path) -> None:
        """PascalCase function name resolves to kebab-case directory."""
        (tmp_path / "lambda" / "create-order").mkdir(parents=True)
        result = _resolve_code_path_from_name("CreateOrderFunction", tmp_path)
        assert result == tmp_path / "lambda" / "create-order"

    @pytest.mark.asyncio
    async def test_resolve_code_path_from_name_not_found(self, tmp_path) -> None:
        """Returns None when no matching directory exists."""
        (tmp_path / "lambda").mkdir(parents=True)
        result = _resolve_code_path_from_name("UnknownFunction", tmp_path)
        assert result is None

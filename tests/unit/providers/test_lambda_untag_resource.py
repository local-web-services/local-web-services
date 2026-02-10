"""Tests for Lambda UntagResource operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestUntagResource:
    """Tests for DELETE /2017-03-31/tags/{arn}?tagKeys=key1,key2."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_untag_resource(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend", "version": "1.0"}},
        )

        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env,team"},
        )
        assert resp.status_code == 204

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        assert "team" not in data["Tags"]
        assert data["Tags"]["version"] == "1.0"

    @pytest.mark.asyncio
    async def test_untag_single_key(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )

        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env"},
        )
        assert resp.status_code == 204

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        assert data["Tags"]["team"] == "backend"

    @pytest.mark.asyncio
    async def test_untag_nonexistent_key_is_noop(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )

        resp = await client.delete(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "nonexistent"},
        )
        assert resp.status_code == 204

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        assert resp.json()["Tags"]["env"] == "prod"

    @pytest.mark.asyncio
    async def test_untag_via_2015_api_version(self, client) -> None:
        await client.post(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )

        resp = await client.delete(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            params={"tagKeys": "env"},
        )
        assert resp.status_code == 204

        resp = await client.get(f"/2015-03-31/tags/{_FUNC_ARN}")
        data = resp.json()
        assert "env" not in data["Tags"]
        assert data["Tags"]["team"] == "backend"

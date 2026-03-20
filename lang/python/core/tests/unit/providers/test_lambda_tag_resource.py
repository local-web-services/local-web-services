"""Tests for Lambda TagResource operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestTagResource:
    """Tests for POST /2017-03-31/tags/{arn}."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_tag_resource(self, client) -> None:
        resp = await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )
        assert resp.status_code == 204, f"Expected {204!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_tags_are_returned_by_list_tags(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod", "team": "backend"}},
        )

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Tags"]["env"] == "prod", f'Expected {"prod"!r} but got {data["Tags"]["env"]!r}'
        assert data["Tags"]["team"] == "backend", f'Expected {"backend"!r} but got {data["Tags"]["team"]!r}'

    @pytest.mark.asyncio
    async def test_tag_resource_merges_tags(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"team": "backend"}},
        )

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["Tags"]["env"] == "prod", f'Expected {"prod"!r} but got {data["Tags"]["env"]!r}'
        assert data["Tags"]["team"] == "backend", f'Expected {"backend"!r} but got {data["Tags"]["team"]!r}'

    @pytest.mark.asyncio
    async def test_tag_resource_overwrites_existing_key(self, client) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "dev"}},
        )
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )

        resp = await client.get(f"/2017-03-31/tags/{_FUNC_ARN}")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json()["Tags"]["env"] == "prod", f'Expected {"prod"!r} but got {resp.json()["Tags"]["env"]!r}'

    @pytest.mark.asyncio
    async def test_tag_resource_via_2015_api_version(self, client) -> None:
        resp = await client.post(
            f"/2015-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "staging"}},
        )
        assert resp.status_code == 204, f"Expected {204!r} but got {resp.status_code!r}"

        resp = await client.get(f"/2015-03-31/tags/{_FUNC_ARN}")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        assert resp.json()["Tags"]["env"] == "staging", f'Expected {"staging"!r} but got {resp.json()["Tags"]["env"]!r}'

    @pytest.mark.asyncio
    async def test_tags_stored_in_registry(self, client, registry) -> None:
        await client.post(
            f"/2017-03-31/tags/{_FUNC_ARN}",
            json={"Tags": {"env": "prod"}},
        )

        tags = registry.get_tags(_FUNC_ARN)
        assert tags == {"env": "prod"}, "Expected {0!r} but got {1!r}".format({"env": "prod"}, tags)

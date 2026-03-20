"""Tests for Lambda ListEventSourceMappings operation."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestListEventSourceMappings:
    """Tests for GET /2015-03-31/event-source-mappings/."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_lambda_management_app(registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_list_event_source_mappings_returns_empty(self, client) -> None:
        resp = await client.get("/2015-03-31/event-source-mappings")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["EventSourceMappings"] == [], (
            f'Expected {[]!r} but got {data["EventSourceMappings"]!r}'
        )

    @pytest.mark.asyncio
    async def test_list_event_source_mappings_response_structure(self, client) -> None:
        resp = await client.get("/2015-03-31/event-source-mappings")
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert "EventSourceMappings" in data, (
            f'Expected {"EventSourceMappings"!r} to be in {data!r}'
        )
        assert isinstance(data["EventSourceMappings"], list), (
            f'Expected instance of {list!r} but got {type(data["EventSourceMappings"])!r}'
        )

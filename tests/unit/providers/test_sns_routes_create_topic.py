"""Tests for SNS route-level topic management operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider
from lws.providers.sns.routes import create_sns_app


@pytest.fixture
async def provider():
    p = SnsProvider()
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: SnsProvider) -> httpx.AsyncClient:
    app = create_sns_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestCreateTopic:
    @pytest.mark.asyncio
    async def test_create_topic_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        resp = await client.post("/", data={"Action": "CreateTopic", "Name": "my-topic"})

        assert resp.status_code == 200
        assert "CreateTopicResponse" in resp.text
        assert "my-topic" in resp.text

        # Verify topic was actually created
        topics = provider.list_topics()
        assert len(topics) == 1
        assert topics[0].topic_name == "my-topic"

    @pytest.mark.asyncio
    async def test_create_topic_idempotent(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        resp1 = await client.post("/", data={"Action": "CreateTopic", "Name": "my-topic"})
        resp2 = await client.post("/", data={"Action": "CreateTopic", "Name": "my-topic"})

        assert resp1.status_code == 200
        assert resp2.status_code == 200

        topics = provider.list_topics()
        assert len(topics) == 1

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
        # Arrange
        topic_name = "my-topic"
        expected_status = 200
        expected_topic_count = 1

        # Act
        resp = await client.post("/", data={"Action": "CreateTopic", "Name": topic_name})

        # Assert
        assert resp.status_code == expected_status
        assert "CreateTopicResponse" in resp.text
        assert topic_name in resp.text
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count
        assert actual_topics[0].topic_name == topic_name

    @pytest.mark.asyncio
    async def test_create_topic_idempotent(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_status = 200
        expected_topic_count = 1

        # Act
        resp1 = await client.post("/", data={"Action": "CreateTopic", "Name": topic_name})
        resp2 = await client.post("/", data={"Action": "CreateTopic", "Name": topic_name})

        # Assert
        assert resp1.status_code == expected_status
        assert resp2.status_code == expected_status
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count

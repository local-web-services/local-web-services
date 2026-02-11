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


class TestDeleteTopic:
    @pytest.mark.asyncio
    async def test_delete_topic_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        await provider.create_topic("my-topic")
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_status = 200
        expected_topic_count = 0

        # Act
        resp = await client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})

        # Assert
        assert resp.status_code == expected_status
        assert "DeleteTopicResponse" in resp.text
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count

    @pytest.mark.asyncio
    async def test_delete_topic_not_found(self, client: httpx.AsyncClient) -> None:
        # Arrange
        topic_arn = "arn:aws:sns:us-east-1:000000000000:nonexistent"
        expected_status = 404

        # Act
        resp = await client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})

        # Assert
        assert resp.status_code == expected_status
        assert "NotFound" in resp.text

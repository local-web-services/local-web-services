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


class TestGetTopicAttributes:
    @pytest.mark.asyncio
    async def test_get_topic_attributes_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"

        resp = await client.post("/", data={"Action": "GetTopicAttributes", "TopicArn": topic_arn})

        assert resp.status_code == 200
        assert "GetTopicAttributesResponse" in resp.text
        assert "TopicArn" in resp.text

    @pytest.mark.asyncio
    async def test_get_topic_attributes_not_found(self, client: httpx.AsyncClient) -> None:
        topic_arn = "arn:aws:sns:us-east-1:000000000000:nonexistent"
        resp = await client.post("/", data={"Action": "GetTopicAttributes", "TopicArn": topic_arn})

        assert resp.status_code == 404
        assert "NotFound" in resp.text

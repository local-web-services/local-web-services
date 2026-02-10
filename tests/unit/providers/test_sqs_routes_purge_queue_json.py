"""Tests for SQS route-level queue management operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sqs.provider import SqsProvider
from lws.providers.sqs.routes import create_sqs_app


@pytest.fixture
async def provider():
    p = SqsProvider()
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: SqsProvider) -> httpx.AsyncClient:
    app = create_sqs_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestPurgeQueueJson:
    @pytest.mark.asyncio
    async def test_purge_queue_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("my-queue")
        await provider.send_message("my-queue", "msg1")

        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/my-queue"},
            headers={"X-Amz-Target": "AmazonSQS.PurgeQueue"},
        )

        assert resp.status_code == 200

    @pytest.mark.asyncio
    async def test_purge_queue_not_found(self, client: httpx.AsyncClient) -> None:
        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/nonexistent"},
            headers={"X-Amz-Target": "AmazonSQS.PurgeQueue"},
        )

        assert resp.status_code == 400

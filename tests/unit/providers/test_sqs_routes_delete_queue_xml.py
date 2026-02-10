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


class TestDeleteQueueXml:
    @pytest.mark.asyncio
    async def test_delete_queue_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("my-queue")
        queue_url = "http://localhost:4566/000000000000/my-queue"
        resp = await client.post(
            "/",
            data={"Action": "DeleteQueue", "QueueUrl": queue_url},
        )

        assert resp.status_code == 200
        assert "DeleteQueueResponse" in resp.text

    @pytest.mark.asyncio
    async def test_delete_queue_not_found(self, client: httpx.AsyncClient) -> None:
        queue_url = "http://localhost:4566/000000000000/nonexistent"
        resp = await client.post(
            "/",
            data={"Action": "DeleteQueue", "QueueUrl": queue_url},
        )

        assert resp.status_code == 400
        assert "NonExistentQueue" in resp.text

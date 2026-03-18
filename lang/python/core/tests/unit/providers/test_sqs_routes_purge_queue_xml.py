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


class TestPurgeQueueXml:
    @pytest.mark.asyncio
    async def test_purge_queue_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        queue_name = "my-queue"
        queue_url = "http://localhost:4566/000000000000/my-queue"
        await provider.create_queue(queue_name)
        await provider.send_message(queue_name, "msg1")

        # Act
        resp = await client.post(
            "/",
            data={"Action": "PurgeQueue", "QueueUrl": queue_url},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        assert "PurgeQueueResponse" in resp.text

    @pytest.mark.asyncio
    async def test_purge_queue_not_found(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        queue_url = "http://localhost:4566/000000000000/nonexistent"

        # Act
        resp = await client.post(
            "/",
            data={"Action": "PurgeQueue", "QueueUrl": queue_url},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        assert "NonExistentQueue" in resp.text

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


class TestListQueuesJson:
    @pytest.mark.asyncio
    async def test_list_queues(self, client: httpx.AsyncClient, provider: SqsProvider) -> None:
        # Arrange
        expected_status_code = 200
        expected_queue_count = 2
        await provider.create_queue("queue-a")
        await provider.create_queue("queue-b")

        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"X-Amz-Target": "AmazonSQS.ListQueues"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert "QueueUrls" in data
        actual_queue_count = len(data["QueueUrls"])
        assert actual_queue_count == expected_queue_count

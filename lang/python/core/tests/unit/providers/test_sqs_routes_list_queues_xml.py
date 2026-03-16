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


class TestListQueuesXml:
    @pytest.mark.asyncio
    async def test_list_queues(self, client: httpx.AsyncClient, provider: SqsProvider) -> None:
        # Arrange
        expected_status_code = 200
        queue_name_a = "queue-a"
        queue_name_b = "queue-b"
        await provider.create_queue(queue_name_a)
        await provider.create_queue(queue_name_b)

        # Act
        resp = await client.post("/", data={"Action": "ListQueues"})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        assert "ListQueuesResponse" in resp.text
        assert queue_name_a in resp.text
        assert queue_name_b in resp.text

    @pytest.mark.asyncio
    async def test_list_queues_empty(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post("/", data={"Action": "ListQueues"})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        assert "ListQueuesResponse" in resp.text

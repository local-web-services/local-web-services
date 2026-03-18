"""Tests for SQS ListDeadLetterSourceQueues (JSON protocol)."""

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


_QUEUE_URL = "http://localhost:4566/000000000000/test-queue"
_JSON_HEADERS = {"X-Amz-Target": "AmazonSQS.{action}"}


def _headers(action: str) -> dict[str, str]:
    return {"X-Amz-Target": f"AmazonSQS.{action}"}


class TestListDeadLetterSourceQueuesJson:
    @pytest.mark.asyncio
    async def test_list_dead_letter_source_queues_empty(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        dlq_name = "my-dlq"
        await provider.create_queue(dlq_name)

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/my-dlq"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert data["QueueUrls"] == []

    @pytest.mark.asyncio
    async def test_list_dead_letter_source_queues_with_sources(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        expected_source_count = 2
        dlq_name = "my-dlq"
        source_name_1 = "source-queue-1"
        source_name_2 = "source-queue-2"

        await provider.create_queue(dlq_name)
        await provider.create_queue(source_name_1)
        await provider.create_queue(source_name_2)

        dlq = provider.get_queue(dlq_name)
        source1 = provider.get_queue(source_name_1)
        source2 = provider.get_queue(source_name_2)
        source1.dead_letter_queue = dlq
        source2.dead_letter_queue = dlq

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/my-dlq"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        actual_source_count = len(data["QueueUrls"])
        assert actual_source_count == expected_source_count
        urls = data["QueueUrls"]
        assert any(source_name_1 in url for url in urls)
        assert any(source_name_2 in url for url in urls)

    @pytest.mark.asyncio
    async def test_list_dead_letter_source_queues_nonexistent_queue(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/nonexistent"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert "NonExistentQueue" in data["__type"]

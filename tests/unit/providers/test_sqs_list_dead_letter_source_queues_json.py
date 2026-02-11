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
        await provider.create_queue("my-dlq")

        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/my-dlq"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert data["QueueUrls"] == []

    @pytest.mark.asyncio
    async def test_list_dead_letter_source_queues_with_sources(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("my-dlq")
        await provider.create_queue("source-queue-1")
        await provider.create_queue("source-queue-2")

        # Wire up DLQ references
        dlq = provider.get_queue("my-dlq")
        source1 = provider.get_queue("source-queue-1")
        source2 = provider.get_queue("source-queue-2")
        source1.dead_letter_queue = dlq
        source2.dead_letter_queue = dlq

        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/my-dlq"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["QueueUrls"]) == 2
        urls = data["QueueUrls"]
        assert any("source-queue-1" in url for url in urls)
        assert any("source-queue-2" in url for url in urls)

    @pytest.mark.asyncio
    async def test_list_dead_letter_source_queues_nonexistent_queue(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            json={"QueueUrl": "http://localhost:4566/000000000000/nonexistent"},
            headers=_headers("ListDeadLetterSourceQueues"),
        )

        assert resp.status_code == 400
        data = resp.json()
        assert "NonExistentQueue" in data["__type"]

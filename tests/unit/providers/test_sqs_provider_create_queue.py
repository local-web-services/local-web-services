"""Tests for SQS provider queue management operations."""

from __future__ import annotations

import pytest

from lws.providers.sqs.provider import SqsProvider


@pytest.fixture
async def provider():
    """Provider started with no queues."""
    p = SqsProvider()
    await p.start()
    yield p
    await p.stop()


class TestCreateQueue:
    @pytest.mark.asyncio
    async def test_create_queue(self, provider: SqsProvider) -> None:
        url = await provider.create_queue("my-queue")

        assert "my-queue" in url
        queues = await provider.list_queues()
        assert "my-queue" in queues

    @pytest.mark.asyncio
    async def test_create_queue_idempotent(self, provider: SqsProvider) -> None:
        url1 = await provider.create_queue("my-queue")
        url2 = await provider.create_queue("my-queue")

        assert url1 == url2
        queues = await provider.list_queues()
        assert queues.count("my-queue") == 1

    @pytest.mark.asyncio
    async def test_create_fifo_queue(self, provider: SqsProvider) -> None:
        url = await provider.create_queue("my-queue.fifo")

        assert "my-queue.fifo" in url
        attrs = await provider.get_queue_attributes("my-queue.fifo")
        assert attrs["FifoQueue"] == "true"

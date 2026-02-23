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
        # Arrange
        queue_name = "my-queue"

        # Act
        url = await provider.create_queue(queue_name)

        # Assert
        assert queue_name in url
        queues = await provider.list_queues()
        assert queue_name in queues

    @pytest.mark.asyncio
    async def test_create_queue_idempotent(self, provider: SqsProvider) -> None:
        # Arrange
        queue_name = "my-queue"
        expected_count = 1

        # Act
        url1 = await provider.create_queue(queue_name)
        url2 = await provider.create_queue(queue_name)

        # Assert
        assert url1 == url2
        queues = await provider.list_queues()
        actual_count = queues.count(queue_name)
        assert actual_count == expected_count

    @pytest.mark.asyncio
    async def test_create_fifo_queue(self, provider: SqsProvider) -> None:
        # Arrange
        queue_name = "my-queue.fifo"
        expected_fifo_attr = "true"

        # Act
        url = await provider.create_queue(queue_name)

        # Assert
        assert queue_name in url
        attrs = await provider.get_queue_attributes(queue_name)
        actual_fifo_attr = attrs["FifoQueue"]
        assert actual_fifo_attr == expected_fifo_attr

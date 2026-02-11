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


class TestDeleteQueue:
    @pytest.mark.asyncio
    async def test_delete_queue(self, provider: SqsProvider) -> None:
        # Arrange
        queue_name = "my-queue"
        await provider.create_queue(queue_name)

        # Act
        await provider.delete_queue(queue_name)

        # Assert
        queues = await provider.list_queues()
        assert queue_name not in queues

    @pytest.mark.asyncio
    async def test_delete_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.delete_queue("nonexistent")

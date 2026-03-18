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


class TestPurgeQueue:
    @pytest.mark.asyncio
    async def test_purge_queue(self, provider: SqsProvider) -> None:
        # Arrange
        queue_name = "my-queue"
        await provider.create_queue(queue_name)
        await provider.send_message(queue_name, "msg1")
        await provider.send_message(queue_name, "msg2")

        # Act
        await provider.purge_queue(queue_name)

        # Assert
        msgs = await provider.receive_messages(queue_name)
        assert msgs == []

    @pytest.mark.asyncio
    async def test_purge_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.purge_queue("nonexistent")

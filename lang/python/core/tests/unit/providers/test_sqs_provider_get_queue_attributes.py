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


class TestGetQueueAttributes:
    @pytest.mark.asyncio
    async def test_get_queue_attributes(self, provider: SqsProvider) -> None:
        # Arrange
        queue_name = "my-queue"
        await provider.create_queue(queue_name)

        # Act
        attrs = await provider.get_queue_attributes(queue_name)

        # Assert
        assert "QueueArn" in attrs, f'Expected {"QueueArn"!r} to be in {attrs!r}'
        assert queue_name in attrs["QueueArn"], f'Expected {queue_name!r} to be in {attrs["QueueArn"]!r}'
        assert "ApproximateNumberOfMessages" in attrs, f'Expected {"ApproximateNumberOfMessages"!r} to be in {attrs!r}'
        assert "VisibilityTimeout" in attrs, f'Expected {"VisibilityTimeout"!r} to be in {attrs!r}'

    @pytest.mark.asyncio
    async def test_get_attributes_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.get_queue_attributes("nonexistent")

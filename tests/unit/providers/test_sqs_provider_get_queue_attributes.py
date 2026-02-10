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
        await provider.create_queue("my-queue")
        attrs = await provider.get_queue_attributes("my-queue")

        assert "QueueArn" in attrs
        assert "my-queue" in attrs["QueueArn"]
        assert "ApproximateNumberOfMessages" in attrs
        assert "VisibilityTimeout" in attrs

    @pytest.mark.asyncio
    async def test_get_attributes_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.get_queue_attributes("nonexistent")

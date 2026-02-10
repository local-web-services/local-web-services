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
        await provider.create_queue("my-queue")
        await provider.delete_queue("my-queue")

        queues = await provider.list_queues()
        assert "my-queue" not in queues

    @pytest.mark.asyncio
    async def test_delete_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.delete_queue("nonexistent")

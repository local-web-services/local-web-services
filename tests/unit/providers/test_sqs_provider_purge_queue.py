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
        await provider.create_queue("my-queue")
        await provider.send_message("my-queue", "msg1")
        await provider.send_message("my-queue", "msg2")

        await provider.purge_queue("my-queue")

        msgs = await provider.receive_messages("my-queue")
        assert msgs == []

    @pytest.mark.asyncio
    async def test_purge_nonexistent_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.purge_queue("nonexistent")

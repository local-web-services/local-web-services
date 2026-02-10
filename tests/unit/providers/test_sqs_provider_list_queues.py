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


class TestListQueues:
    @pytest.mark.asyncio
    async def test_list_queues_empty(self, provider: SqsProvider) -> None:
        queues = await provider.list_queues()
        assert queues == []

    @pytest.mark.asyncio
    async def test_list_queues_sorted(self, provider: SqsProvider) -> None:
        await provider.create_queue("zebra")
        await provider.create_queue("alpha")
        await provider.create_queue("middle")

        queues = await provider.list_queues()
        assert queues == ["alpha", "middle", "zebra"]

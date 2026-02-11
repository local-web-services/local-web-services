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
        # Act
        queues = await provider.list_queues()

        # Assert
        assert queues == []

    @pytest.mark.asyncio
    async def test_list_queues_sorted(self, provider: SqsProvider) -> None:
        # Arrange
        expected_queues = ["alpha", "middle", "zebra"]
        await provider.create_queue("zebra")
        await provider.create_queue("alpha")
        await provider.create_queue("middle")

        # Act
        actual_queues = await provider.list_queues()

        # Assert
        assert actual_queues == expected_queues

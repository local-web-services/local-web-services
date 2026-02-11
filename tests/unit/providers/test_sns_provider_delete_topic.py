"""Tests for SNS provider topic management operations."""

from __future__ import annotations

import pytest

from lws.providers.sns.provider import SnsProvider


@pytest.fixture
async def provider():
    """Provider started with no topics."""
    p = SnsProvider()
    await p.start()
    yield p
    await p.stop()


class TestDeleteTopic:
    @pytest.mark.asyncio
    async def test_delete_topic(self, provider: SnsProvider) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_topic_count = 0
        await provider.create_topic(topic_name)

        # Act
        await provider.delete_topic(topic_name)

        # Assert
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count

    @pytest.mark.asyncio
    async def test_delete_nonexistent_raises(self, provider: SnsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.delete_topic("nonexistent")

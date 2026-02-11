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


class TestCreateTopic:
    @pytest.mark.asyncio
    async def test_create_topic(self, provider: SnsProvider) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_topic_count = 1

        # Act
        actual_arn = await provider.create_topic(topic_name)

        # Assert
        assert topic_name in actual_arn
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count
        assert actual_topics[0].topic_name == topic_name

    @pytest.mark.asyncio
    async def test_create_topic_idempotent(self, provider: SnsProvider) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_topic_count = 1

        # Act
        actual_arn1 = await provider.create_topic(topic_name)
        actual_arn2 = await provider.create_topic(topic_name)

        # Assert
        assert actual_arn1 == actual_arn2
        actual_topics = provider.list_topics()
        assert len(actual_topics) == expected_topic_count

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


class TestGetTopicAttributes:
    @pytest.mark.asyncio
    async def test_get_topic_attributes(self, provider: SnsProvider) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_display_name = "my-topic"
        expected_subscriptions_confirmed = "0"
        await provider.create_topic(topic_name)

        # Act
        actual_attrs = await provider.get_topic_attributes(topic_name)

        # Assert
        assert "TopicArn" in actual_attrs, f'Expected {"TopicArn"!r} to be in {actual_attrs!r}'
        assert topic_name in actual_attrs["TopicArn"], f'Expected {topic_name!r} to be in {actual_attrs["TopicArn"]!r}'
        assert actual_attrs["DisplayName"] == expected_display_name, f'Expected {expected_display_name!r} but got {actual_attrs["DisplayName"]!r}'
        assert actual_attrs["SubscriptionsConfirmed"] == expected_subscriptions_confirmed, f'Expected {expected_subscriptions_confirmed!r} but got {actual_attrs["SubscriptionsConfirmed"]!r}'

    @pytest.mark.asyncio
    async def test_get_attributes_nonexistent_raises(self, provider: SnsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.get_topic_attributes("nonexistent")

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
        await provider.create_topic("my-topic")
        attrs = await provider.get_topic_attributes("my-topic")

        assert "TopicArn" in attrs
        assert "my-topic" in attrs["TopicArn"]
        assert attrs["DisplayName"] == "my-topic"
        assert attrs["SubscriptionsConfirmed"] == "0"

    @pytest.mark.asyncio
    async def test_get_attributes_nonexistent_raises(self, provider: SnsProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.get_topic_attributes("nonexistent")

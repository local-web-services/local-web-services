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
        arn = await provider.create_topic("my-topic")

        assert "my-topic" in arn
        topics = provider.list_topics()
        assert len(topics) == 1
        assert topics[0].topic_name == "my-topic"

    @pytest.mark.asyncio
    async def test_create_topic_idempotent(self, provider: SnsProvider) -> None:
        arn1 = await provider.create_topic("my-topic")
        arn2 = await provider.create_topic("my-topic")

        assert arn1 == arn2
        topics = provider.list_topics()
        assert len(topics) == 1

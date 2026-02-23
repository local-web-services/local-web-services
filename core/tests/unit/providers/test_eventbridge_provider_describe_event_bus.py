"""Tests for EventBridge provider management operations."""

from __future__ import annotations

import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider


@pytest.fixture()
async def provider() -> EventBridgeProvider:
    p = EventBridgeProvider()
    await p.start()
    yield p
    await p.stop()


class TestDescribeEventBus:
    async def test_describe_default(self, provider: EventBridgeProvider) -> None:
        attrs = provider.describe_event_bus("default")
        assert attrs["Name"] == "default"
        assert "Arn" in attrs

    async def test_describe_created_bus(self, provider: EventBridgeProvider) -> None:
        await provider.create_event_bus("my-bus")
        attrs = provider.describe_event_bus("my-bus")
        assert attrs["Name"] == "my-bus"

    async def test_describe_nonexistent_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Event bus not found"):
            provider.describe_event_bus("nonexistent")

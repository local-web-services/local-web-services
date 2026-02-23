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


class TestDeleteEventBus:
    async def test_delete_removes_from_list(self, provider: EventBridgeProvider) -> None:
        await provider.create_event_bus("to-delete")
        await provider.delete_event_bus("to-delete")
        buses = provider.list_buses()
        bus_names = [b.bus_name for b in buses]
        assert "to-delete" not in bus_names

    async def test_delete_nonexistent_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Event bus not found"):
            await provider.delete_event_bus("nonexistent")

    async def test_delete_default_bus_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(ValueError, match="Cannot delete the default event bus"):
            await provider.delete_event_bus("default")

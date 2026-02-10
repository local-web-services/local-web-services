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


class TestCreateEventBus:
    async def test_create_returns_arn(self, provider: EventBridgeProvider) -> None:
        arn = await provider.create_event_bus("my-bus")
        assert arn == "arn:aws:events:us-east-1:000000000000:event-bus/my-bus"

    async def test_created_appears_in_list(self, provider: EventBridgeProvider) -> None:
        await provider.create_event_bus("new-bus")
        buses = provider.list_buses()
        bus_names = [b.bus_name for b in buses]
        assert "new-bus" in bus_names

    async def test_create_is_idempotent(self, provider: EventBridgeProvider) -> None:
        arn1 = await provider.create_event_bus("idem-bus")
        arn2 = await provider.create_event_bus("idem-bus")
        assert arn1 == arn2

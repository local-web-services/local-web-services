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
        expected_arn = "arn:aws:events:us-east-1:000000000000:event-bus/my-bus"
        actual_arn = await provider.create_event_bus("my-bus")
        assert actual_arn == expected_arn

    async def test_created_appears_in_list(self, provider: EventBridgeProvider) -> None:
        await provider.create_event_bus("new-bus")
        buses = provider.list_buses()
        bus_names = [b.bus_name for b in buses]
        assert "new-bus" in bus_names

    async def test_create_raises_when_bus_already_exists(
        self, provider: EventBridgeProvider
    ) -> None:
        """Creating a bus that already exists must raise ValueError."""
        await provider.create_event_bus("idem-bus")
        expected_error_type = ValueError
        with pytest.raises(expected_error_type):
            await provider.create_event_bus("idem-bus")

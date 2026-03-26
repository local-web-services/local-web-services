"""Tests for ServiceTaskBridge capacity enforcement on EventBridge dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeEventBridge, FakeExhaustedCapacity, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestEventBridgeCapacity:
    """EventBridge dispatch is blocked when capacity is exhausted."""

    async def test_put_events_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        eb = FakeEventBridge()
        bridge = make_bridge(eventbridge=eb, events_capacity=FakeExhaustedCapacity())
        expected_error = "EventBridge capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::events:putEvents",
                {"Entries": [{"Source": "my.app", "DetailType": "test", "Detail": "{}"}]},
            )

    async def test_put_events_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        eb = FakeEventBridge()
        bridge = make_bridge(eventbridge=eb, events_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::events:putEvents",
            {"Entries": [{"Source": "my.app", "DetailType": "test", "Detail": "{}"}]},
        )

        # Assert
        actual_entries = result.get("Entries")
        assert actual_entries is not None, "Expected Entries in the response"
        expected_count = 1
        assert (
            len(actual_entries) == expected_count
        ), f"Expected {expected_count} entry but got {len(actual_entries)}"

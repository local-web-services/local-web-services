"""Tests for ServiceTaskBridge EventBridge service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeEventBridge


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeEventBridge:
    """EventBridge service integration dispatching."""

    async def test_put_events_calls_provider(self) -> None:
        # Arrange
        expected_entries = [{"Source": "app", "DetailType": "Order", "Detail": "{}"}]
        eb = FakeEventBridge()
        bridge = make_bridge(eventbridge=eb)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::events:putEvents",
            {"Entries": expected_entries},
        )

        # Assert
        actual_entries = eb.put_calls[0]
        actual_failed = result["FailedEntryCount"]
        assert actual_entries == expected_entries
        assert actual_failed == 0
        assert "Entries" in result

    async def test_put_events_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No EventBridge provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::events:putEvents", {})

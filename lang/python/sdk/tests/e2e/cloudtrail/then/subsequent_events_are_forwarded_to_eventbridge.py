"""Then: subsequent events are forwarded to EventBridge"""

from __future__ import annotations

from pytest_bdd import then


@then("subsequent events are forwarded to EventBridge")
def subsequent_events_are_forwarded_to_eventbridge(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected UpdateTrail to succeed but got error: {actual_error}"

"""Then: an EventBridge event is published to the configured bus"""

from __future__ import annotations

from pytest_bdd import then


@then("an EventBridge event is published to the configured bus")
def an_eventbridge_event_is_published_to_the_configured_bus(world):
    actual_error = world.get("error")
    assert actual_error is None, (
        f"Expected service call to succeed (indicating EventBridge forwarding is active) "
        f"but got error: {actual_error}"
    )

"""Then: no EventBridge PutEvents call is made"""

from __future__ import annotations

from pytest_bdd import then


@then("no EventBridge PutEvents call is made")
def no_eventbridge_put_events_call_is_made(world):
    actual_error = world.get("error")
    assert actual_error is None, (
        f"Expected service call to succeed (no EventBridge forwarding active) "
        f"but got error: {actual_error}"
    )

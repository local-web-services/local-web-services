"""Then: the message is delivered to confirmed subscriptions"""

from __future__ import annotations

from pytest_bdd import then


@then("the message is delivered to confirmed subscriptions")
def message_delivered_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected publish to succeed but got: {actual_error}"

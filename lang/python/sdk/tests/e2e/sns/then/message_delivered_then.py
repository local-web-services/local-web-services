"""Then: the "sns" "message" will be delivered to confirmed subscriptions"""

from __future__ import annotations

from pytest_bdd import then


@then('the "sns" "message" will be delivered to confirmed subscriptions')
def message_delivered_then(world):
    assert world["error"] is None, f"Expected publish to succeed but got: {world['error']}"

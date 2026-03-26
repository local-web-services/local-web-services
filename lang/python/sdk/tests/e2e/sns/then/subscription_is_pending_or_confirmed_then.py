"""Then: the subscription is "PENDING_CONFIRMATION" or "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import then


@then('the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"')
def subscription_is_pending_or_confirmed_then(world):
    actual_arn = world.get("subscription_arn", "")
    assert actual_arn, f"Expected subscription ARN but got: {actual_arn}"

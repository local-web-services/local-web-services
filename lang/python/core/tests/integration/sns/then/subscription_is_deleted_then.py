"""Then: the subscription is deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the subscription is deleted")
def subscription_is_deleted_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected unsubscribe to succeed but got: {actual_error}"

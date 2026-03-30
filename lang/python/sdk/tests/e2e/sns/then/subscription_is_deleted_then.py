"""Then: the subscription is deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the subscription is deleted")
def subscription_is_deleted_then(world):
    assert world["error"] is None, f"Expected unsubscribe to succeed but got: {world['error']}"

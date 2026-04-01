"""Then: the "sns" "subscription" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "sns" "subscription" will be "DELETED"')
def subscription_is_deleted_then(world):
    assert world["error"] is None, f"Expected unsubscribe to succeed but got: {world['error']}"

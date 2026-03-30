"""Then: the subscription is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the subscription is "DELETED"')
def subscription_is_deleted_by_removal_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected subscription removal to succeed but got: {actual_error}"

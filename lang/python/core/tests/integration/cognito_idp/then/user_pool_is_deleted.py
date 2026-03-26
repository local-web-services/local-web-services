"""Then: the user pool is "DELETED" along with all its users and groups"""

from __future__ import annotations

from pytest_bdd import then


@then('the user pool is "DELETED" along with all its users and groups')
def user_pool_is_deleted(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user pool deletion to succeed but got: {actual_error}"

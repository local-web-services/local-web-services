"""Then: the user is deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the user is deleted")
def user_is_deleted_then(world):
    assert world["error"] is None, f"Expected user deletion to succeed but got: {world['error']}"

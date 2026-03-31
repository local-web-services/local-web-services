"""Then: the "cognito" "user" will be deleted, their sessions are expired, and group memberships are cleared"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "cognito" "user" will be deleted, their sessions are expired, and group memberships are cleared'
)
def user_is_deleted_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user deletion to succeed but got: {actual_error}"

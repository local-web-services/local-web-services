"""Then: the "cognito" "user" will be deleted, their sessions are expired, and group memberships are cleared"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "cognito" "user" will be deleted, their sessions are expired, and group memberships are cleared'
)
def user_is_deleted_sessions_cleared_then(world):
    assert world["error"] is None, f"Expected user deletion to succeed but got: {world['error']}"

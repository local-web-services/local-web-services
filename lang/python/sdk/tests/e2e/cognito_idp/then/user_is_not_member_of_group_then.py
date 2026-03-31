"""Then: the "cognito" "user" will no longer be a member of the "cognito" "group" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "user" will no longer be a member of the "cognito" "group"')
def user_is_not_member_of_group_then(world):
    assert (
        world["error"] is None
    ), f"Expected user removal from group to succeed but got: {world['error']}"

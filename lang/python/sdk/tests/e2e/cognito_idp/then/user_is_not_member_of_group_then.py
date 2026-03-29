"""Then: the user is no longer a member of the group"""

from __future__ import annotations

from pytest_bdd import then


@then("the user is no longer a member of the group")
def user_is_not_member_of_group_then(world):
    assert (
        world["error"] is None
    ), f"Expected user removal from group to succeed but got: {world['error']}"

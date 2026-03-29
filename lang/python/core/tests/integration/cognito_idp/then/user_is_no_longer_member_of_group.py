"""Then: the user is no longer a member of the group"""

from __future__ import annotations

from pytest_bdd import then


@then("the user is no longer a member of the group")
def user_is_no_longer_member_of_group(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected remove-user-from-group to succeed but got: {actual_error}"

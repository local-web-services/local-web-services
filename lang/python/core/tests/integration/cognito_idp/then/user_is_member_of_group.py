"""Then: the user is a member of the group"""

from __future__ import annotations

from pytest_bdd import then


@then("the user is a member of the group")
def user_is_member_of_group(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected add-user-to-group to succeed but got: {actual_error}"

"""Then: the group is "ACTIVE" and associated with the pool"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_GROUP_NAME


@then('the group is "ACTIVE" and associated with the pool')
def group_is_active_and_associated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected group creation to succeed but got: {actual_error}"
    actual_group = world["result"].get("Group", {})
    expected_group_name = world.get("group_name", INT_GROUP_NAME)
    actual_group_name = actual_group.get("GroupName", "")
    assert (
        actual_group_name == expected_group_name
    ), f"Expected group name '{expected_group_name}' but got '{actual_group_name}'"

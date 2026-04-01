"""Then: the "cognito" "group" will be deleted and all users will be removed from it"""

from __future__ import annotations

from pytest_bdd import then


@then('the "cognito" "group" will be deleted and all users will be removed from it')
def group_is_deleted(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected group deletion to succeed but got: {actual_error}"

"""Then: the "memorydb" "user" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "memorydb" "user" will be deleted')
def user_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user delete to succeed but got: {actual_error}"

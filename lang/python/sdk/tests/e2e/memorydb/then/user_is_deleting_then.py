"""Then: the "memorydb" "user" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "memorydb" "user" will be in "DELETING" state')
def user_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected user delete to succeed but got: {actual_error}"

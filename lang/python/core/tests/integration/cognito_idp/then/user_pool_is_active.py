"""Then: the user pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the user pool is "ACTIVE"')
def user_pool_is_active(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected user pool creation to succeed but got: {actual_error}"
    actual_pool = world["result"]["UserPool"]
    expected_status = "Enabled"
    actual_status = actual_pool.get("Status", "")
    assert (
        actual_status == expected_status
    ), f"Expected pool status '{expected_status}' but got '{actual_status}'"

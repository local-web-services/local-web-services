"""Then: the table has no policy"""

from __future__ import annotations

from pytest_bdd import then


@then("the table has no policy")
def table_has_no_policy_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_table_policy to succeed but got: {actual_error}"

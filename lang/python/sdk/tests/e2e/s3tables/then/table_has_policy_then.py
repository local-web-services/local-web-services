"""Then: the "s3 tables" "table" has a policy"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "table" has a policy')
def table_has_policy_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected put_table_policy to succeed but got: {actual_error}"

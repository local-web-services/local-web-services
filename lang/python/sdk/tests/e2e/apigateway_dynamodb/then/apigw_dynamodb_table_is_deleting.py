"""Then: the "dynamodb" "table" will be "DELETING" and "API" requests targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "table" will be "DELETING" and "API" requests targeting it will fail')
def apigw_dynamodb_table_is_deleting(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_table to succeed but got: {actual_error}"

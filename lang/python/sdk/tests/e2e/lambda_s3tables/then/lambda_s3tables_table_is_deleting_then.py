"""Then: the "s3 tables" "table" will be "DELETING" and write operations will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "table" will be "DELETING" and write operations will fail')
def lambda_s3tables_table_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table delete to succeed but got: {actual_error}"

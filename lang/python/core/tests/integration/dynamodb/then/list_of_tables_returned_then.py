"""Then: the list of "dynamodb" "table"s will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the list of "dynamodb" "table"s will be returned')
def list_of_tables_returned_then(world: dict):
    expected_field = "TableNames"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected TableNames in result but got: {actual_result}"

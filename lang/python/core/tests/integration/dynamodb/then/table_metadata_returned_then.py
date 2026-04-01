"""Then: the "dynamodb" "table" metadata will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "table" metadata will be returned')
def table_metadata_returned_then(world: dict):
    expected_field = "Table"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected table metadata with 'Table' key but got: {actual_result}"

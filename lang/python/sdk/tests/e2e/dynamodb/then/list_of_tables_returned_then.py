"""Then: the list of tables is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of tables is returned")
def list_of_tables_returned_then(world):
    expected_field = "TableNames"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected TableNames in result but got: {actual_result}"

"""Then: the table description is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the table description is returned")
def table_description_returned_then(world: dict):
    expected_field = "Table"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected table description with 'Table' key but got: {actual_result}"

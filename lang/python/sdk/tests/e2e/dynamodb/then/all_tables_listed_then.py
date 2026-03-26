"""Then: all tables are listed"""

from __future__ import annotations

from pytest_bdd import then


@then("all tables are listed")
def all_tables_listed_then(world):
    expected_field = "TableNames"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected TableNames in result but got: {actual_result}"

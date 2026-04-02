"""Then: all "dynamodb" "item"s will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('all "dynamodb" "item"s will be returned')
def all_items_returned_then(world):
    expected_field = "Items"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Items in result but got: {actual_result}"

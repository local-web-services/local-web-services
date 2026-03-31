"""Then: the "dynamodb" "item" value will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "item" value will be returned')
def item_value_returned_then(world: dict):
    expected_field = "Item"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Item in result but got: {actual_result}"

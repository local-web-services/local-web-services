"""Then: matching items are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("matching items are returned")
def matching_items_returned_then(world: dict):
    expected_field = "Items"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Items in query result but got: {actual_result}"

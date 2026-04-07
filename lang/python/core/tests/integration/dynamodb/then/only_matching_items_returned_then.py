"""Then: only "dynamodb" "item"s matching the filter expression will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('only "dynamodb" "item"s matching the filter expression will be returned')
def only_matching_items_returned_then(world: dict):
    expected_count = 1
    actual_result = world["result"]
    actual_items = actual_result.get("Items", []) if actual_result else []
    actual_count = len(actual_items)
    assert (
        actual_count == expected_count
    ), f"Expected {expected_count!r} items but got {actual_count!r}: {actual_items!r}"

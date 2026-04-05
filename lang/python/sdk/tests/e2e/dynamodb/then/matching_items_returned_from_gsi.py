"""Then: matching "dynamodb" "item"s will be returned from the "dynamodb" "GSI" """

from __future__ import annotations

from pytest_bdd import then


@then('matching "dynamodb" "item"s will be returned from the "dynamodb" "GSI"')
def matching_items_returned_from_gsi(world):
    expected_min_count = 1
    actual_result = world["result"]
    actual_count = actual_result.get("Count", 0)
    assert actual_count >= expected_min_count, (
        f"Expected at least {expected_min_count!r} item(s) from GSI query"
        f" but got {actual_count!r}"
    )

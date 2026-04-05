"""Then: matching "dynamodb" "item"s will be returned from the "dynamodb" "GSI" """

from __future__ import annotations

from pytest_bdd import then


@then('matching "dynamodb" "item"s will be returned from the "dynamodb" "GSI"')
def matching_items_returned_from_gsi(world: dict):
    expected_min_count = 1
    actual_count = world["result"]["Count"]
    assert (
        actual_count >= expected_min_count
    ), f"Expected at least {expected_min_count!r} item(s) from GSI query but got {actual_count!r}"

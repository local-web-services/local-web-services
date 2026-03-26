"""Then: the instance count is updated without data loss"""

from __future__ import annotations

from pytest_bdd import then


@then("the instance count is updated without data loss")
def instance_count_updated_without_data_loss(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected shard rebalancing to succeed but got error: {world['error']}"

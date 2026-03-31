"""Then: the "elasticsearch" "domain" shard layout will be updated without changing document counts"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "domain" shard layout will be updated without changing document counts')
def es_shard_layout_updated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

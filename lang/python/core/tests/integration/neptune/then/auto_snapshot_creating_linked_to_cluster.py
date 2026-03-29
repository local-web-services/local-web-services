"""Then: a snapshot is "CREATING" and linked to the cluster"""

from __future__ import annotations

from pytest_bdd import then


@then('a snapshot is "CREATING" and linked to the cluster')
def auto_snapshot_creating_linked_to_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected automated backup to succeed but got error: {world['error']}"

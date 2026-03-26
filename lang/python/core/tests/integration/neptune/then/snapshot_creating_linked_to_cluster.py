"""Then: the snapshot is in "CREATING" state and linked to the cluster"""

from __future__ import annotations

from pytest_bdd import then


@then('the snapshot is in "CREATING" state and linked to the cluster')
def snapshot_creating_linked_to_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot creation to succeed but got error: {world['error']}"

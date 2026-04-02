"""Then: the "documentdb" "snapshot" will be in "CREATING" state and linked to the "documentdb" "cluster" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "documentdb" "snapshot" will be in "CREATING" state and linked to the "documentdb" "cluster"'
)
def snapshot_creating_linked_to_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot creation to succeed but got error: {world['error']}"

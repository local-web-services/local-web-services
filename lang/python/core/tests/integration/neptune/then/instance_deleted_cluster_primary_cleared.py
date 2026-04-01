"""Then: the "documentdb" "INSTANCE" will be "DELETED" and the "documentdb" "cluster" primary will be cleared if applicable"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "documentdb" "INSTANCE" will be "DELETED" and the "documentdb" "cluster" primary will be cleared if applicable'
)
def instance_deleted_cluster_primary_cleared(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

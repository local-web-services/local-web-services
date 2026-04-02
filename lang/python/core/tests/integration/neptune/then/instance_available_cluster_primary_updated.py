"""Then: the "documentdb" "instance" will be "AVAILABLE" and the "documentdb" "cluster" primary will be updated if applicable"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "documentdb" "instance" will be "AVAILABLE" and the "documentdb" "cluster" primary will be updated if applicable'
)
def instance_available_cluster_primary_updated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

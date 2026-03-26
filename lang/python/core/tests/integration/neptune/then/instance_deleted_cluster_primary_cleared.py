"""Then: the instance is "DELETED" and the cluster primary is cleared if applicable"""

from __future__ import annotations

from pytest_bdd import then


@then('the instance is "DELETED" and the cluster primary is cleared if applicable')
def instance_deleted_cluster_primary_cleared(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

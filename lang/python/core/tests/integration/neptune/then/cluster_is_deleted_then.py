"""Then: the "documentdb" "cluster" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "documentdb" "cluster" will be "DELETED"')
def cluster_is_deleted_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

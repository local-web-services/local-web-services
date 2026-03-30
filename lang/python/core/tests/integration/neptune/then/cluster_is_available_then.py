"""Then: the cluster is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

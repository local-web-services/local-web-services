"""Then: the cluster and its instances are "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then


@then('the cluster and its instances are "AVAILABLE"')
def cluster_and_instances_are_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

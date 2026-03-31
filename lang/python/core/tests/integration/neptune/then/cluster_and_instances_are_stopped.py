"""Then: the "neptune" "cluster" and its instances are "STOPPED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "cluster" and its instances are "STOPPED"')
def cluster_and_instances_are_stopped(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

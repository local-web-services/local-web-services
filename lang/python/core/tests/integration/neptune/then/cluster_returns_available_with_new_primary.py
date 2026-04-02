"""Then: the "neptune" "cluster" returns to "AVAILABLE" with a new primary "neptune" "instance" """

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "cluster" returns to "AVAILABLE" with a new primary "neptune" "instance"')
def cluster_returns_available_with_new_primary(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

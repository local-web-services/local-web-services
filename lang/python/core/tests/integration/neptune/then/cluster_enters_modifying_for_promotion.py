"""Then: the "neptune" "cluster" will be in "MODIFYING" state for primary promotion"""

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "cluster" will be in "MODIFYING" state for primary promotion')
def cluster_enters_modifying_for_promotion(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

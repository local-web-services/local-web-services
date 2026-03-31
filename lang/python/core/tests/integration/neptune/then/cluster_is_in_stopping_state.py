"""Then: the "neptune" "cluster" will be in "STOPPING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "cluster" will be in "STOPPING" state')
def cluster_is_in_stopping_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster stop to succeed but got error: {world['error']}"

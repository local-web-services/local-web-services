"""Then: the cluster is in "STARTING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is in "STARTING" state')
def cluster_is_in_starting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster start to succeed but got error: {world['error']}"

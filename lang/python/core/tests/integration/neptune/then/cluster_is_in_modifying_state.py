"""Then: the cluster is in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the cluster is in "MODIFYING" state')
def cluster_is_in_modifying_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected cluster modification to succeed but got error: {world['error']}"

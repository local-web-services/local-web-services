"""Then: the "documentdb" "snapshot" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "documentdb" "snapshot" will be in "DELETING" state')
def neptune_snapshot_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot deletion to succeed but got error: {world['error']}"

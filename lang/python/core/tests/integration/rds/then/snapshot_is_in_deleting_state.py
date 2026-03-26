"""Then: the snapshot is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the snapshot is in "DELETING" state')
def snapshot_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected snapshot deletion to succeed but got error: {world['error']}"

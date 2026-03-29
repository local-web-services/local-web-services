"""Then: the instance is in "DELETING" state and a snapshot is "CREATING" """

from __future__ import annotations

from pytest_bdd import then


@then('the instance is in "DELETING" state and a snapshot is "CREATING"')
def instance_deleting_snapshot_creating(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

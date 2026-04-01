"""Then: the "rds" "instance" will be in "DELETING" state and a "rds" "snapshot" will be "CREATING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be in "DELETING" state and a "rds" "snapshot" will be "CREATING"')
def instance_deleting_snapshot_creating(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

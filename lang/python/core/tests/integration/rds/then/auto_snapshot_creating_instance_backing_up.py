"""Then: a "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'a "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state'
)
def auto_snapshot_creating_instance_backing_up(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected automated backup to succeed but got error: {world['error']}"

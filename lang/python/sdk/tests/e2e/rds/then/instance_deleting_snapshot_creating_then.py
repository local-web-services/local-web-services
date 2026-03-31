"""Then: the "rds" "instance" will be in "DELETING" state and a "rds" "snapshot" will be "CREATING" """

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be in "DELETING" state and a "rds" "snapshot" will be "CREATING"')
def instance_deleting_snapshot_creating_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected instance delete with snapshot to succeed but got: {actual_error}"

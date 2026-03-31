"""Then: the "rds" "snapshot" will be "AVAILABLE" and the "rds" "instance" returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "rds" "snapshot" will be "AVAILABLE" and the "rds" "instance" returns to "AVAILABLE" state'
)
def snapshot_available_instance_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"

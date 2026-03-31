"""Then: the "neptune" "INSTANCE" will be in "REBOOTING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "INSTANCE" will be in "REBOOTING" state')
def neptune_instance_is_in_rebooting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance reboot to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("rebooting", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"

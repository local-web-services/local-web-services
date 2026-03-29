"""Then: the instance is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the instance is in "DELETING" state')
def neptune_instance_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance deletion to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("deleting", "deleted")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"

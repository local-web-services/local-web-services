"""Then: the "documentdb" "INSTANCE" will be in "CREATING" state and associated with the "documentdb" "cluster" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "neptune" "INSTANCE" will be in "CREATING" state and associated with the "neptune" "cluster"'
)
@then(
    'the "documentdb" "INSTANCE" will be in "CREATING" state and associated with the "documentdb" "cluster"'
)
def instance_is_creating_and_associated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance creation to succeed but got error: {world['error']}"
    actual_status = actual_result.get("DBInstance", {}).get("DBInstanceStatus", "")
    expected_valid_statuses = ("creating", "available")
    assert (
        actual_status in expected_valid_statuses
    ), f"Expected instance status in {expected_valid_statuses} but got: {actual_status!r}"

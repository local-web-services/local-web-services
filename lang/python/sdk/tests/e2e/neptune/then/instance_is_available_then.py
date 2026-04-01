"""Then: the "neptune" "INSTANCE" will be "AVAILABLE" and the "neptune" "cluster" primary will be updated if applicable"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_INSTANCE


@then(
    'the "neptune" "INSTANCE" will be "AVAILABLE" and the "neptune" "cluster" primary will be updated if applicable'
)
def instance_is_available_then(lws_session, world):
    expected_status = "available"
    instance_id = world.get("instance_id", TEST_INSTANCE)
    response = lws_session.client("neptune").describe_db_instances(DBInstanceIdentifier=instance_id)
    actual_status = response["DBInstances"][0]["DBInstanceStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}"

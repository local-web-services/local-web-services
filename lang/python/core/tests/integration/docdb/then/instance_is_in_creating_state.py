"""Then: the instance is in "CREATING" state and associated with the cluster"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_INSTANCE_ID


@then('the instance is in "CREATING" state and associated with the cluster')
def instance_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected instance creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBInstances"},
        json={"DBInstanceIdentifier": INT_INSTANCE_ID},
    )
    instances = r.json().get("DBInstances", [])
    assert instances, f"Expected instance '{INT_INSTANCE_ID}' to exist but found none"
    expected_statuses = ("available", "creating")
    actual_status = instances[0]["DBInstanceStatus"]
    assert (
        actual_status in expected_statuses
    ), f"Expected instance status in {expected_statuses} but got: {actual_status}"

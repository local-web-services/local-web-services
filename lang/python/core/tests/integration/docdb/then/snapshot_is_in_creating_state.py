"""Then: the "documentdb" "snapshot" will be in "CREATING" state and linked to the "documentdb" "cluster" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_SNAPSHOT_ID


@then(
    'the "documentdb" "snapshot" will be in "CREATING" state and linked to the "documentdb" "cluster"'
)
def snapshot_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusterSnapshots"},
        json={"DBClusterSnapshotIdentifier": INT_SNAPSHOT_ID},
    )
    snapshots = r.json().get("DBClusterSnapshots", [])
    assert snapshots, f"Expected snapshot '{INT_SNAPSHOT_ID}' to exist but found none"

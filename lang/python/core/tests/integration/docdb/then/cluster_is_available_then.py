"""Then: the "documentdb" "cluster" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@then('the "documentdb" "cluster" will be "AVAILABLE"')
def cluster_is_available_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusters"},
        json={"DBClusterIdentifier": INT_CLUSTER_ID},
    )
    clusters = r.json().get("DBClusters", [])
    assert clusters, f"Expected cluster '{INT_CLUSTER_ID}' to exist but found none"
    expected_status = "available"
    actual_status = clusters[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected cluster status '{expected_status}' but got: {actual_status}"

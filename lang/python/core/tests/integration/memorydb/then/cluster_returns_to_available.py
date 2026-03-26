"""Then: the cluster returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeClusters"},
        json={"ClusterName": INT_CLUSTER_NAME},
    )
    clusters = r.json().get("Clusters", [])
    assert clusters, f"Expected cluster '{INT_CLUSTER_NAME}' to exist but found none"
    expected_status = "available"
    actual_status = clusters[0]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected cluster status '{expected_status}' but got: {actual_status}"

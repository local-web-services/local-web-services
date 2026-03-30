"""Then: the cluster returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@then('the cluster returns to "AVAILABLE" state')
def cluster_returns_to_available(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    clusters = r.json().get("CacheClusters", [])
    assert clusters, f"Expected cluster '{INT_CLUSTER_ID}' to exist but found none"
    expected_status = "available"
    actual_status = clusters[0]["CacheClusterStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected cluster status '{expected_status}' but got: {actual_status}"

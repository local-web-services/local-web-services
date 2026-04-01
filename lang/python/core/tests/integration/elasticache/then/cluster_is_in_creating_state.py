"""Then: the "documentdb" "cluster" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@then('the "elasticache" "cluster" will be in "CREATING" state')
@then('the "documentdb" "cluster" will be in "CREATING" state')
def cluster_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    clusters = r.json().get("CacheClusters", [])
    assert clusters, f"Expected cluster '{INT_CLUSTER_ID}' to exist but found none"
    expected_statuses = ("available", "creating")
    actual_status = clusters[0]["CacheClusterStatus"]
    assert (
        actual_status in expected_statuses
    ), f"Expected cluster status in {expected_statuses} but got: {actual_status}"

"""Then: the cluster is in "CREATING" state with the memcached engine"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@then('the cluster is in "CREATING" state with the memcached engine')
def cluster_is_in_creating_state_memcached(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected cluster creation to succeed but got: {actual_error}"
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    clusters = r.json().get("CacheClusters", [])
    assert clusters, f"Expected cluster '{INT_CLUSTER_ID}' to exist but found none"
    expected_engine = "memcached"
    actual_engine = clusters[0].get("Engine", "")
    assert (
        actual_engine == expected_engine
    ), f"Expected engine '{expected_engine}' but got: {actual_engine}"

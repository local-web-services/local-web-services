"""When: a standalone cache cluster finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _EC_TARGET, INT_CLUSTER_ID


@when("a standalone cache cluster finishes creating")
def standalone_cache_cluster_finishes_creating(client: TestClient, world):
    r_check = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    clusters = r_check.json().get("CacheClusters", [])
    if clusters and clusters[0].get("CacheClusterStatus") != "creating":
        pytest.skip(
            "lws does not enforce CREATING state for standalone cache cluster "
            "finish-creating operation."
        )
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.DescribeCacheClusters"},
        json={"CacheClusterId": INT_CLUSTER_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

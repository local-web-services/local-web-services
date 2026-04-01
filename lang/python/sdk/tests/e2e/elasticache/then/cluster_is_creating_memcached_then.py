"""Then: the "elasticache" "cluster" will be in "CREATING" state with the memcached engine"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the "elasticache" "cluster" will be in "CREATING" state with the memcached engine')
def cluster_is_creating_memcached_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("elasticache").describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"

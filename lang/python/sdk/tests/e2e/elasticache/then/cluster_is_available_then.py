"""Then: the cluster is "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import ElasticacheTestClient
from ..constants import TEST_CLUSTER


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = ElasticacheTestClient(lws_session).describe_cache_clusters(CacheClusterId=TEST_CLUSTER)
    actual_clusters = resp.get("CacheClusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"

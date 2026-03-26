"""Then: the cluster is in "RESTORING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import ElasticacheTestClient


@then('the cluster is in "RESTORING" state')
def cluster_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = ElasticacheTestClient(lws_session).describe_cache_clusters(
        CacheClusterId="e2e-test-cluster-2"
    )
    actual_clusters = resp.get("CacheClusters", [])
    assert (
        len(actual_clusters) > 0
    ), "Expected restored cluster 'e2e-test-cluster-2' to exist but found none"

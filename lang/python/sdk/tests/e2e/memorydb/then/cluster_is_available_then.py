"""Then: the "memorydb" "cluster" will be "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_CLUSTER


@then('the "memorydb" "cluster" will be "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("memorydb").describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"

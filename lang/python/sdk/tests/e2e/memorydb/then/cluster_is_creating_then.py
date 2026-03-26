"""Then: the cluster is in "CREATING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import MemorydbTestClient
from ..constants import TEST_CLUSTER


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = MemorydbTestClient(lws_session).describe_clusters(ClusterName=TEST_CLUSTER)
    actual_clusters = resp.get("Clusters", [])
    assert len(actual_clusters) > 0, f"Expected cluster '{TEST_CLUSTER}' to exist but found none"
    actual_status = actual_clusters[0]["Status"]
    expected_statuses = ("creating", "available")
    assert (
        actual_status in expected_statuses
    ), f"Expected cluster status in {expected_statuses} but got: {actual_status}"

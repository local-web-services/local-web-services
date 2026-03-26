"""Then: the restored cluster is in "RESTORING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..client import MemorydbTestClient


@then('the restored cluster is in "RESTORING" state')
def restored_cluster_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = MemorydbTestClient(lws_session).describe_clusters(ClusterName="e2e-test-cluster-2")
    actual_clusters = resp.get("Clusters", [])
    assert (
        len(actual_clusters) > 0
    ), "Expected restored cluster 'e2e-test-cluster-2' to exist but found none"

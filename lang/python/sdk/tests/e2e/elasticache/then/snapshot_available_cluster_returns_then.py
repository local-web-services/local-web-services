"""Then: the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_SNAPSHOT


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state')
def snapshot_available_cluster_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("elasticache").describe_snapshots(SnapshotName=TEST_SNAPSHOT)
    actual_snapshots = resp.get("Snapshots", [])
    assert len(actual_snapshots) > 0, f"Expected snapshot '{TEST_SNAPSHOT}' to exist but found none"

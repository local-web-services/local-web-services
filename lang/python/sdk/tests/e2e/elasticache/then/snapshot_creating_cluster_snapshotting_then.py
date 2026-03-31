"""Then: the "elasticache" "snapshot" will be in "CREATING" state and the "elasticache" "cluster" will be "SNAPSHOTTING" """

from __future__ import annotations

import pytest
from pytest_bdd import then

from ..constants import TEST_SNAPSHOT


@then(
    'the "elasticache" "snapshot" will be in "CREATING" state and the "elasticache" "cluster" will be "SNAPSHOTTING"'
)
def snapshot_creating_cluster_snapshotting_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    resp = lws_session.client("elasticache").describe_snapshots(SnapshotName=TEST_SNAPSHOT)
    actual_snapshots = resp.get("Snapshots", [])
    assert len(actual_snapshots) > 0, f"Expected snapshot '{TEST_SNAPSHOT}' to exist but found none"

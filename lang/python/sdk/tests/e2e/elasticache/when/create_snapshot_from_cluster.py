"""When: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@when('an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"')
def create_snapshot_from_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").create_snapshot(
            SnapshotName=TEST_SNAPSHOT, CacheClusterId=TEST_CLUSTER
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

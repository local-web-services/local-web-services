"""When: an "elasticache" "cluster" is created from an "elasticache" "snapshot" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('an "elasticache" "cluster" is created from an "elasticache" "snapshot"')
def create_cluster_from_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").create_cache_cluster(
            CacheClusterId="e2e-test-cluster-2",
            CacheNodeType="cache.t3.micro",
            Engine="redis",
            NumCacheNodes=1,
            SnapshotName=TEST_SNAPSHOT,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

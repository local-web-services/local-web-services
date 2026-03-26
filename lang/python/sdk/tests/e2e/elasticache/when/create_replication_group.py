"""When: a replication group is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when("a replication group is created")
def create_replication_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").create_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP,
            ReplicationGroupDescription="e2e test replication group",
            CacheNodeType="cache.t3.micro",
            Engine="redis",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

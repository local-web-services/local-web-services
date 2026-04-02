"""When: an "elasticache" "subnet group" is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SUBNET_GROUP


@when('an "elasticache" "subnet group" is created')
def create_subnet_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").create_cache_subnet_group(
            CacheSubnetGroupName=TEST_SUBNET_GROUP,
            CacheSubnetGroupDescription="e2e test subnet group",
            SubnetIds=["subnet-12345678"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

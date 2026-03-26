"""When: a cache subnet group is deleted"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SUBNET_GROUP


@when("a cache subnet group is deleted")
def delete_subnet_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").delete_cache_subnet_group(
            CacheSubnetGroupName=TEST_SUBNET_GROUP
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

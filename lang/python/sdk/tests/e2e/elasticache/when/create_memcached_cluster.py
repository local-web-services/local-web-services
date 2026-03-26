"""When: a memcached cache cluster is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when("a memcached cache cluster is created")
def create_memcached_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").create_cache_cluster(
            CacheClusterId=TEST_CLUSTER,
            CacheNodeType="cache.t3.micro",
            Engine="memcached",
            NumCacheNodes=1,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

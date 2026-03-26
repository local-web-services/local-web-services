"""When: a standalone cache cluster is deleted"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticacheTestClient
from ..constants import TEST_CLUSTER


@when("a standalone cache cluster is deleted")
def delete_cache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = ElasticacheTestClient(lws_session).delete_cache_cluster(
            CacheClusterId=TEST_CLUSTER
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

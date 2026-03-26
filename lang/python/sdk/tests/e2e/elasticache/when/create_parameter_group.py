"""When: a cache parameter group is created"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticacheTestClient
from ..constants import TEST_PARAMETER_GROUP


@when("a cache parameter group is created")
def create_parameter_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = ElasticacheTestClient(lws_session).create_cache_parameter_group(
            CacheParameterGroupName=TEST_PARAMETER_GROUP,
            CacheParameterGroupFamily="redis6.x",
            Description="e2e test parameter group",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

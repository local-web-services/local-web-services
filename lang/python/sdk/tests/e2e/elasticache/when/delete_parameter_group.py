"""When: an "elasticache" parameter group is deleted"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAMETER_GROUP


@when('an "elasticache" parameter group is deleted')
def delete_parameter_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").delete_cache_parameter_group(
            CacheParameterGroupName=TEST_PARAMETER_GROUP
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

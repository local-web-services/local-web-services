"""When: a "elasticache" "replication group" is deleted"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when('a "elasticache" "replication group" is deleted')
def delete_replication_group(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        world["result"] = lws_session.client("elasticache").delete_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

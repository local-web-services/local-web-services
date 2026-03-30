"""When: a replication group configuration is modified"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when("a replication group configuration is modified")
def modify_replication_group(lws_session, world):
    try:
        world["result"] = lws_session.client("elasticache").modify_replication_group(
            ReplicationGroupId=TEST_REPLICATION_GROUP,
            ReplicationGroupDescription="e2e test rg updated",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

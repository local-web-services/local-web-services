"""When: a database cluster configuration is modified"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when("a database cluster configuration is modified")
def modify_db_cluster(lws_session, world):
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").modify_db_cluster(
            DBClusterIdentifier=cluster_id,
            ApplyImmediately=True,
        )
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

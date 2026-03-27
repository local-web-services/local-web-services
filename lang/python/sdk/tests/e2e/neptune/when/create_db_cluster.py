"""When: a database cluster is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when("a database cluster is created")
def create_db_cluster(lws_session, world):
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").create_db_cluster(
            DBClusterIdentifier=cluster_id, Engine="neptune"
        )
        world["result"] = result
        world["cluster_id"] = cluster_id
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

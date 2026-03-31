"""When: a "neptune" "cluster" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "neptune" "cluster" is deleted')
def delete_db_cluster(lws_session, world):
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").delete_db_cluster(
            DBClusterIdentifier=cluster_id, SkipFinalSnapshot=True
        )
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

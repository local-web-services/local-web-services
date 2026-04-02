"""When: a stopped "neptune" "cluster" is started"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a stopped "neptune" "cluster" is started')
def start_db_cluster(lws_session, world):
    lws_session.lifecycle("neptune").modify_dwell_ms(5000).apply()
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").start_db_cluster(DBClusterIdentifier=cluster_id)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

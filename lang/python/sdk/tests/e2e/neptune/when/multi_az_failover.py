"""When: a multi-"AZ" failover is triggered on a "neptune" "cluster" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a multi-"AZ" failover is triggered on a "neptune" "cluster"')
def multi_az_failover(lws_session, world):
    try:
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").failover_db_cluster(DBClusterIdentifier=cluster_id)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

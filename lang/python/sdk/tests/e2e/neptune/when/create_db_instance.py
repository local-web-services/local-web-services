"""When: a "neptune" "instance" is created in an available neptune cluster"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CLUSTER, TEST_INSTANCE


@when('a "neptune" "instance" is created in an available neptune cluster')
def create_db_instance(lws_session, world):
    try:
        instance_id = world.get("instance_id", TEST_INSTANCE)
        cluster_id = world.get("cluster_id", TEST_CLUSTER)
        result = lws_session.client("neptune").create_db_instance(
            DBInstanceIdentifier=instance_id,
            DBInstanceClass="db.t3.medium",
            Engine="neptune",
            DBClusterIdentifier=cluster_id,
        )
        world["result"] = result
        world["instance_id"] = instance_id
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

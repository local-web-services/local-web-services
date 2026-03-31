"""When: a stopped neptune database neptune cluster is started"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "neptune" "instance" is rebooted')
def reboot_db_instance(lws_session, world):
    try:
        instance_id = world.get("instance_id", TEST_INSTANCE)
        result = lws_session.client("neptune").reboot_db_instance(DBInstanceIdentifier=instance_id)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc

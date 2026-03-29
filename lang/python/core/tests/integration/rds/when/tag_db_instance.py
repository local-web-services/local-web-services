"""When: a tag is applied to a database instance"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import RdsTestClient
from ..constants import INT_DB_INSTANCE, INT_TAG_KEY, INT_TAG_VALUE, _store


@when("a tag is applied to a database instance")
def tag_db_instance(client: TestClient, world: dict):
    describe_r = RdsTestClient(client).post(
        "DescribeDBInstances", {"DBInstanceIdentifier": INT_DB_INSTANCE}
    )
    if describe_r.status_code != 200:
        world["result"] = None
        world["error"] = describe_r.json()
        return
    instances = describe_r.json().get("DBInstances", [])
    if not instances:
        world["result"] = None
        world["error"] = {"message": "DB instance not found"}
        return
    resource_name = instances[0].get("DBInstanceArn", "")
    r = RdsTestClient(client).post(
        "AddTagsToResource",
        {"ResourceName": resource_name, "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
    _store(world, r)

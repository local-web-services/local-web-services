"""When: a table finishes creating and becomes active"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE, _try_json


@when("a table finishes creating and becomes active")
def activate_table(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post("DescribeTable", {"TableName": TEST_TABLE})
    if r.status_code != 200:
        world["result"] = None
        world["error"] = _try_json(r)
        return
    body = _try_json(r)
    actual_status = body.get("Table", {}).get("TableStatus", "")
    if actual_status != "CREATING":
        world["result"] = None
        world["error"] = {"message": f"Table is not in CREATING state (got {actual_status!r})"}
        return
    world["result"] = body
    world["error"] = None

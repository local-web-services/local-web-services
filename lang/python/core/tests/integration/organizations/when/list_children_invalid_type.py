"""When: "ListChildren" is called with an invalid child type"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('"ListChildren" is called with an invalid child type')
def list_children_invalid_type(client: TestClient, world):
    root_id = world.get("root_id", "r-0001")
    status, body = OrganizationsTestClient(client).post(
        "ListChildren", {"ParentId": root_id, "ChildType": "INVALID"}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body

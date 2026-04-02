"""When: "ListChildren" is called with OU child type"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('"ListChildren" is called with the root id and child type "ORGANIZATIONAL_UNIT"')
def list_children_ou_type(client: TestClient, world):
    root_id = world["root_id"]
    status, body = OrganizationsTestClient(client).post(
        "ListChildren", {"ParentId": root_id, "ChildType": "ORGANIZATIONAL_UNIT"}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body

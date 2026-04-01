"""When: "ListChildren" is called with account child type"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when(
    '"ListChildren" is called with the "organizations" "organizational unit" id and child type "ACCOUNT"'
)
def list_children_account_type(client: TestClient, world):
    ou_id = world["ou_id"]
    status, body = OrganizationsTestClient(client).post(
        "ListChildren", {"ParentId": ou_id, "ChildType": "ACCOUNT"}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body

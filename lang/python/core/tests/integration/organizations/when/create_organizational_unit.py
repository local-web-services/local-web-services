"""When: an "organizations" "organizational unit" is created under a parent"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_OU_NAME


@when('an "organizations" "organizational unit" is created under a parent')
def create_organizational_unit(client: TestClient, world):
    parent_id = world.get("parent_id") or world.get("root_id")
    status, body = OrganizationsTestClient(client).post(
        "CreateOrganizationalUnit", {"ParentId": parent_id, "Name": INT_OU_NAME}
    )
    if status == 200:
        world["result"] = body
        world["ou_id"] = body.get("OrganizationalUnit", {}).get("Id")
    else:
        world["error"] = body

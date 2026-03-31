"""When: an "organizations" "organizational unit" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('an "organizations" "organizational unit" is deleted')
def delete_organizational_unit(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "DeleteOrganizationalUnit", {"OrganizationalUnitId": world["ou_id"]}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body

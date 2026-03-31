"""Given: the "organizations" "organizational unit" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the "organizations" "organizational unit" existed and was "ACTIVE"')
def ou_exists_and_active(client: TestClient, world):
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()
    world["ou_id"] = OrganizationsTestClient(client).create_ou(world["root_id"])
    world["parent_id"] = world["root_id"]

"""Given: the organizational unit already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_OU_NAME


@given("the organizational unit already exists")
def ou_already_exists(client: TestClient, world):
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()
    world["ou_id"] = OrganizationsTestClient(client).create_ou(world["root_id"], INT_OU_NAME)
    world["existing_ou_name"] = INT_OU_NAME

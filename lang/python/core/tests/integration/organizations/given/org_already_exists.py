"""Given: the organization already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given("the organization already exists")
def org_already_exists(client: TestClient, world):
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()

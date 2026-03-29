"""Given: the account exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the account exists and is "ACTIVE"')
def account_exists_and_active(client: TestClient, world):
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()
    world["account_id"] = OrganizationsTestClient(client).create_account()
    world["source_parent_id"] = world["root_id"]

"""Given: the account does not already exist"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given("the account does not already exist")
def account_not_already_exist(client: TestClient, world):
    """Create org so account operations have a valid context."""
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()

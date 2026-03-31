"""Given: the destination "organizations" "parent" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the destination "organizations" "parent" was "ACTIVE"')
def destination_parent_active(client: TestClient, world):
    world["dest_parent_id"] = OrganizationsTestClient(client).create_ou(
        world["root_id"], "int-test-dest-ou-1"
    )

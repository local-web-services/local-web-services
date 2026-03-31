"""Given: the "organizations" "policy" will be attached to the "organizations" "target" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the "organizations" "policy" is attached to the "organizations" "target"')
@given('the "organizations" "policy" will be attached to the "organizations" "target"')
def policy_attached_to_target(client: TestClient, world):
    resp = OrganizationsTestClient(client).create_org()
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = OrganizationsTestClient(client).get_root_id()
    world["policy_id"] = OrganizationsTestClient(client).create_policy()
    world["target_id"] = world["root_id"]
    OrganizationsTestClient(client).attach_policy(world["policy_id"], world["target_id"])

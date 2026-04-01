"""Given: the "organizations" "organizational unit" has attached policies"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the "organizations" "organizational unit" has attached policies')
def ou_has_attached_policies(client: TestClient, world):
    policy_id = OrganizationsTestClient(client).create_policy()
    world["policy_id"] = policy_id
    OrganizationsTestClient(client).attach_policy(policy_id, world["ou_id"])

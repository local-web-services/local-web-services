"""Given: the policy is already attached to the target"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given("the policy is already attached to the target")
def policy_already_attached(client: TestClient, world):
    OrganizationsTestClient(client).attach_policy(world["policy_id"], world["target_id"])

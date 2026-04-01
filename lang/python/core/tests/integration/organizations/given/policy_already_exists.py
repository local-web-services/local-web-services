"""Given: the "organizations" "policy" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the "organizations" "policy" already existed')
def policy_already_exists(client: TestClient, world):
    world["policy_id"] = OrganizationsTestClient(client).create_policy()

"""Given: the policy already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the policy already exists")
def policy_already_exists(lws_session, world):
    world["policy_id"] = OrganizationsTestClient(lws_session).create_policy()

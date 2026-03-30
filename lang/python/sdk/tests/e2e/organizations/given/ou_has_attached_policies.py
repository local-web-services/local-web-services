"""Given: the organizational unit has attached policies"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the organizational unit has attached policies")
def ou_has_attached_policies(lws_session, world):
    policy_id = OrganizationsTestClient(lws_session).create_policy()
    world["policy_id"] = policy_id
    OrganizationsTestClient(lws_session).attach_policy(policy_id, world["ou_id"])

"""Given: the policy is already attached to the target"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the policy is already attached to the target")
def policy_already_attached(lws_session, world):
    OrganizationsTestClient(lws_session).attach_policy(world["policy_id"], world["target_id"])

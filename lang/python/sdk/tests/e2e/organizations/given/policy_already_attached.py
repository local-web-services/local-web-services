"""Given: the "organizations" "policy" was already attached to the "organizations" "target" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" "policy" was already attached to the "organizations" "target"')
def policy_already_attached(lws_session, world):
    OrganizationsTestClient(lws_session).attach_policy(world["policy_id"], world["target_id"])

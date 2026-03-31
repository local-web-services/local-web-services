"""Given: the "organizations" "policy" will be attached to the "organizations" "target" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" "policy" is attached to the "organizations" "target"')
def policy_attached_to_target(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["policy_id"] = OrganizationsTestClient(lws_session).create_policy()
    world["target_id"] = world["root_id"]
    OrganizationsTestClient(lws_session).attach_policy(world["policy_id"], world["target_id"])

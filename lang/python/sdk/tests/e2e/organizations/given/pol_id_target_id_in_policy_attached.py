"""Given: (pol_id + '#' + target_id) in policy_attached"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("(pol_id + '#' + target_id) in policy_attached")
def pol_id_target_id_in_policy_attached(lws_session, world):
    OrganizationsTestClient(lws_session).create_org()
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    policy_id = OrganizationsTestClient(lws_session).create_policy()
    OrganizationsTestClient(lws_session).attach_policy(policy_id, world["root_id"])
    world["policy_id"] = policy_id
    world["target_id"] = world["root_id"]

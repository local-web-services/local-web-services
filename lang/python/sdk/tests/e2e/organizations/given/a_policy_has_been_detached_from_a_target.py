"""Given: a policy has been detached from a target"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("a policy has been detached from a target")
def a_policy_has_been_detached_from_a_target(lws_session, world):
    OrganizationsTestClient(lws_session).create_org()
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    policy_id = OrganizationsTestClient(lws_session).create_policy()
    OrganizationsTestClient(lws_session).attach_policy(policy_id, world["root_id"])
    OrganizationsTestClient(lws_session).detach_policy(
        PolicyId=policy_id, TargetId=world["root_id"]
    )

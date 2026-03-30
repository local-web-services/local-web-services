"""Given: pol_id in policy_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("pol_id in policy_status")
def pol_id_in_policy_status(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["policy_id"] = OrganizationsTestClient(lws_session).create_policy()
    world["target_id"] = world["root_id"]

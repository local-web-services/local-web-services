"""Given: the "organizations" "policy" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" "policy" existed and was "ACTIVE"')
def policy_exists_and_active(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["policy_id"] = OrganizationsTestClient(lws_session).create_policy()
    world["target_id"] = world["root_id"]

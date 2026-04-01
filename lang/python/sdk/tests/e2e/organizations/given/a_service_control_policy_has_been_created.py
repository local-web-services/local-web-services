"""Given: a service control policy has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("a service control policy has been created")
def a_service_control_policy_has_been_created(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["policy_id"] = OrganizationsTestClient(lws_session).create_policy()

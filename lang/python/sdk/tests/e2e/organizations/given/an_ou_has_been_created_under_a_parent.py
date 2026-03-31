"""Given: an "organizations" "organizational unit" is created under a parent"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('an "organizations" "organizational unit" is created under a parent')
def an_ou_has_been_created_under_a_parent(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    OrganizationsTestClient(lws_session).create_ou(world["root_id"])

"""Given: the organization already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the organization already exists")
def org_already_exists(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()

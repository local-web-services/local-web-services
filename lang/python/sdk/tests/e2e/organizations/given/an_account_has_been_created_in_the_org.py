"""Given: an account has been created in the organization"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("an account has been created in the organization")
def an_account_has_been_created_in_the_org(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["account_id"] = OrganizationsTestClient(lws_session).create_account()

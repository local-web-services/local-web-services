"""Given: the "organizations" "account" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" "account" existed and was "ACTIVE"')
def account_exists_and_active(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["account_id"] = OrganizationsTestClient(lws_session).create_account()
    world["source_parent_id"] = world["root_id"]

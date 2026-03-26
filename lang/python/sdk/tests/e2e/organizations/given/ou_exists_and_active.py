"""Given: the organizational unit exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the organizational unit exists and is "ACTIVE"')
def ou_exists_and_active(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["ou_id"] = OrganizationsTestClient(lws_session).create_ou(world["root_id"])
    world["parent_id"] = world["root_id"]

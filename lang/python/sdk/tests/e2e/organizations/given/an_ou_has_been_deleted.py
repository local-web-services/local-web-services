"""Given: an "organizations" "organizational unit" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('an "organizations" "organizational unit" is deleted')
def an_ou_has_been_deleted(lws_session, world):
    OrganizationsTestClient(lws_session).create_org()
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    ou_id = OrganizationsTestClient(lws_session).create_ou(world["root_id"])
    OrganizationsTestClient(lws_session).delete_organizational_unit(OrganizationalUnitId=ou_id)

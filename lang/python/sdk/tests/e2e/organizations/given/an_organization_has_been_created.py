"""Given: an organization has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("an organization has been created")
def an_organization_has_been_created(lws_session):
    OrganizationsTestClient(lws_session).create_org()

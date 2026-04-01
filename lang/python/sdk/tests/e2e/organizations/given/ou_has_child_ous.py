"""Given: the "organizations" "organizational unit" has child organizational units"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given('the "organizations" "organizational unit" has child organizational units')
def ou_has_child_ous(lws_session, world):
    OrganizationsTestClient(lws_session).create_ou(world["ou_id"], "e2e-test-child-ou-1")

"""Given: 'org-1' in org_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("'org-1' in org_status")
def org_1_in_org_status(lws_session):
    OrganizationsTestClient(lws_session).create_org()

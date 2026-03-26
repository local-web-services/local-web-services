"""Then: the root is "ACTIVE" whenever the organization exists"""

from __future__ import annotations

from pytest_bdd import then

from ..client import OrganizationsTestClient


@then('the root is "ACTIVE" whenever the organization exists')
def root_active_when_org_exists(lws_session):
    roots_resp = OrganizationsTestClient(lws_session).list_roots()
    actual_roots = roots_resp["Roots"]
    assert len(actual_roots) > 0, "Expected at least one active root but got none"

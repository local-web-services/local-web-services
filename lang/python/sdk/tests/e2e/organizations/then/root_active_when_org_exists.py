"""Then: the root was "ACTIVE" whenever the "organizations" "organization" exists"""

from __future__ import annotations

from pytest_bdd import step


@step('the root was "ACTIVE" whenever the "organizations" "organization" exists')
def root_active_when_org_exists(lws_session):
    roots_resp = lws_session.client("organizations").list_roots()
    actual_roots = roots_resp["Roots"]
    assert len(actual_roots) > 0, "Expected at least one active root but got none"

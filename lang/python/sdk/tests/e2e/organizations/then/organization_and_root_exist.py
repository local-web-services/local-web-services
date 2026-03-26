"""Then: the organization and its root exist"""

from __future__ import annotations

from pytest_bdd import then


@then("the organization and its root exist")
def organization_and_root_exist(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected CreateOrganization to succeed but got: {world['error']}"
    org_resp = lws_session.client("organizations").describe_organization()
    actual_org_id = org_resp["Organization"]["Id"]
    assert actual_org_id is not None, "Expected organization Id to be set but got None"
    roots_resp = lws_session.client("organizations").list_roots()
    actual_roots = roots_resp["Roots"]
    assert len(actual_roots) > 0, "Expected at least one root but got none"

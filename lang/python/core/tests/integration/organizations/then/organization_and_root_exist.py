"""Then: the "organizations" "organization" and its root will exist"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the "organizations" "organization" and its root will exist')
def organization_and_root_exist(client: TestClient, world):
    actual_create_error = world["error"]
    assert (
        actual_create_error is None
    ), f"Expected CreateOrganization to succeed but got: {actual_create_error}"
    _, org_body = OrganizationsTestClient(client).post("DescribeOrganization", {})
    actual_org_id = org_body.get("Organization", {}).get("Id")
    assert actual_org_id is not None, "Expected organization Id to be set but got None"
    _, roots_body = OrganizationsTestClient(client).post("ListRoots", {})
    actual_roots = roots_body.get("Roots", [])
    assert len(actual_roots) > 0, "Expected at least one root but got none"

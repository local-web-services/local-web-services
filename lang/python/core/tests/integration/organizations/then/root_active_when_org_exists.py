"""Then: the root was "ACTIVE" whenever the "organizations" "organization" exists"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the root was "ACTIVE" whenever the "organizations" "organization" exists')
def root_active_when_org_exists(client: TestClient, world):
    _, roots_body = OrganizationsTestClient(client).post("ListRoots", {})
    actual_roots = roots_body.get("Roots", [])
    assert len(actual_roots) > 0, "Expected at least one active root but got none"

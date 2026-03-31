"""Then: the "api gateway" "resource" will be deleted along with all its methods and integrations"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "api gateway" "resource" will be deleted along with all its methods and integrations')
def resource_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"

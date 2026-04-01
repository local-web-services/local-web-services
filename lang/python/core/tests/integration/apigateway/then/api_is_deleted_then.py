"""Then: api_is_deleted_then"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _API_DELETED_STEP


@then(
    'the "api gateway" "API" will be deleted along with all its resources, methods, integrations, deployments, and stages'
)
@then(_API_DELETED_STEP)
def api_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"
    list_r = client.get("/restapis")
    actual_items = list_r.json().get("item", [])
    assert len(actual_items) == 0, f"Expected no REST APIs after deletion but found: {actual_items}"

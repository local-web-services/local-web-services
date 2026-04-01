"""Then: the "api gateway" "deployment" will be deleted"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "api gateway" "deployment" will be deleted')
def deployment_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"

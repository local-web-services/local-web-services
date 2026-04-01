"""Then: the "api gateway" "method" will be deleted and its integration will be deleted if it will exist"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then(
    'the "api gateway" "method" will be deleted and its integration will be deleted if it will exist'
)
def method_is_deleted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected delete to succeed but got error: {world['error']}"

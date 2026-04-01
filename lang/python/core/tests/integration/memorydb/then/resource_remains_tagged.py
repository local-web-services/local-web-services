"""Then: the "elasticache" "resource" remains tagged"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "memorydb" "resource" remains tagged')
@then('the "elasticache" "resource" remains tagged')
def resource_remains_tagged(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tagging operation to succeed but got: {actual_error}"

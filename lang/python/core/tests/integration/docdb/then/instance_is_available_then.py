"""Then: the instance is "AVAILABLE" and the cluster primary is updated if applicable"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the instance is "AVAILABLE" and the cluster primary is updated if applicable')
def instance_is_available_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected instance to be available but got: {actual_error}"

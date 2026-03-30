"""Then: the subnet group no longer exists"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then("the subnet group no longer exists")
def subnet_group_no_longer_exists(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected subnet group deletion to succeed but got: {actual_error}"

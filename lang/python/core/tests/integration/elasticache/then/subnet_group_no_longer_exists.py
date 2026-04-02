"""Then: the "elasticache" "subnet group" will no longer exist"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the "elasticache" "subnet group" will no longer exist')
def subnet_group_no_longer_exists(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected subnet group deletion to succeed but got: {actual_error}"

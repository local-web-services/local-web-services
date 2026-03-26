"""Then: the parameters no longer exist"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM


@then("the parameters no longer exist")
def parameters_no_longer_exist(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={},
    )
    actual_names = [p["Name"] for p in r.json().get("Parameters", [])]
    assert (
        INT_PARAM not in actual_names
    ), f"Expected parameter '{INT_PARAM}' to be deleted but found in: {actual_names}"

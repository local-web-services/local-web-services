"""When: parameters are described"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET


@when("parameters are described")
def describe_parameters(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.DescribeParameters"},
        json={},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

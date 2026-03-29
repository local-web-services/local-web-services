"""When: a secret is described"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_SECRET


@when("a secret is described")
def describe_secret(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.DescribeSecret"},
        json={"SecretId": INT_SECRET},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

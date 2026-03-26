"""When: a deleted secret is restored within the recovery window"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_SECRET


@when("a deleted secret is restored within the recovery window")
def restore_secret(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.RestoreSecret"},
        json={"SecretId": INT_SECRET},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

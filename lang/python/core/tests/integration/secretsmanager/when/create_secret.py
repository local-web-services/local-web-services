"""When: a "secrets manager" "secret" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_SECRET, INT_VALUE


@when('a "secrets manager" "secret" is created')
def create_secret(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.CreateSecret"},
        json={"Name": INT_SECRET, "SecretString": INT_VALUE},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

"""When: a new value is stored for an active secret"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_SECRET, INT_VALUE2


@when("a new value is stored for an active secret")
def put_secret_value(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.PutSecretValue"},
        json={"SecretId": INT_SECRET, "SecretString": INT_VALUE2},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

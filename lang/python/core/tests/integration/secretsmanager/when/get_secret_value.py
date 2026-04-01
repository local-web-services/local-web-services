"""When: the current value of an active "secrets manager" "secret" is retrieved"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_SECRET


@when('the current value of an active "secrets manager" "secret" is retrieved')
def get_secret_value(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.GetSecretValue"},
        json={"SecretId": INT_SECRET},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

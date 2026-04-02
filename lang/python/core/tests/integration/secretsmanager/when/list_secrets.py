"""When: all "secrets manager" "secret"s are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX


@when('all "secrets manager" "secret"s are listed')
def list_secrets(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.ListSecrets"},
        json={},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

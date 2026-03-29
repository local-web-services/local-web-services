"""When: metadata or description for an active secret is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SM_TARGET_PREFIX, INT_DESCRIPTION, INT_SECRET


@when("metadata or description for an active secret is updated")
def update_secret(sync_client: TestClient, world):
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.UpdateSecret"},
        json={"SecretId": INT_SECRET, "Description": INT_DESCRIPTION},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

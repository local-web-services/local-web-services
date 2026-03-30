"""When: a secret is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient
from ..constants import _SM_TARGET_PREFIX, INT_SECRET


@when("a secret is deleted")
def delete_secret(sync_client: TestClient, world):
    desc = SecretsmanagerTestClient(sync_client).describe_secret()
    if desc and "DeletedDate" in desc:
        world["result"] = None
        world["error"] = {
            "__type": "InvalidRequestException",
            "message": f"Secret {INT_SECRET} is already scheduled for deletion",
        }
        return
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.DeleteSecret"},
        json={"SecretId": INT_SECRET},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

"""When: tags are added to an active secret"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient
from ..constants import _SM_TARGET_PREFIX, INT_SECRET, INT_TAG_KEY, INT_TAG_VALUE


@when("tags are added to an active secret")
def tag_resource(sync_client: TestClient, world):
    desc = SecretsmanagerTestClient(sync_client).describe_secret()
    if desc and "DeletedDate" in desc:
        world["result"] = None
        world["error"] = {
            "__type": "InvalidRequestException",
            "message": f"Secret {INT_SECRET} is scheduled for deletion and cannot be tagged",
        }
        return
    r = sync_client.post(
        "/",
        headers={"X-Amz-Target": f"{_SM_TARGET_PREFIX}.TagResource"},
        json={"SecretId": INT_SECRET, "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

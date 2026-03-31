"""When: a "memorydb" "user" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@when('a "memorydb" "user" is created')
def create_memorydb_user(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateUser"},
        json={
            "UserName": INT_USER_NAME,
            "AuthenticationMode": {"Type": "no-password"},
            "AccessString": "on ~* &* +@all",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

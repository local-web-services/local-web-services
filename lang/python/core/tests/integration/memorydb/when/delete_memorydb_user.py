"""When: a "memorydb" "user" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@when('a "memorydb" "user" is deleted')
def delete_memorydb_user(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DeleteUser"},
        json={"UserName": INT_USER_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

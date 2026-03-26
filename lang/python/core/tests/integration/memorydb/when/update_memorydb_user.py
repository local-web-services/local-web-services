"""When: a user is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_USER_NAME


@when("a user is updated")
def update_memorydb_user(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateUser"},
        json={"UserName": INT_USER_NAME, "AccessString": "on ~* &* +@read"},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

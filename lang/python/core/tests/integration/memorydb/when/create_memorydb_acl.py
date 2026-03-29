"""When: an "ACL" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME


@when('an "ACL" is created')
def create_memorydb_acl(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateACL"},
        json={"ACLName": INT_ACL_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

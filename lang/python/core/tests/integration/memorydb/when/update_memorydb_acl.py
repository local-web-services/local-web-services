"""When: an "ACL" is updated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME


@when('an "ACL" is updated')
def update_memorydb_acl(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateACL"},
        json={"ACLName": INT_ACL_NAME, "UserNamesToAdd": []},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

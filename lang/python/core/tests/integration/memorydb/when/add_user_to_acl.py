"""When: a "memorydb" "user" is added to an "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_ACL_NAME, INT_USER_NAME


@when('a "memorydb" "user" is added to an "memorydb" "ACL"')
def add_user_to_acl(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateACL"},
        json={"ACLName": INT_ACL_NAME, "UserNamesToAdd": [INT_USER_NAME]},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()

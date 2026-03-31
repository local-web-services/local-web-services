"""Given: the "memorydb" "user" membership entry existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient
from ..constants import _MDB_TARGET, INT_ACL_NAME, INT_USER_NAME


@given('the "memorydb" "user" membership entry existed')
def user_membership_entry_exists(client: TestClient):
    MemorydbTestClient(client).create_user()
    MemorydbTestClient(client).create_acl()
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateACL"},
        json={"ACLName": INT_ACL_NAME, "UserNamesToAdd": [INT_USER_NAME]},
    )

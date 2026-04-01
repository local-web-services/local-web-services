"""Given: the "memorydb" "user" is already a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient
from ..constants import _MDB_TARGET, INT_ACL_NAME, INT_USER_NAME


@given('the "memorydb" "user" is already a member of the "memorydb" "ACL"')
def user_is_already_member_of_acl(client: TestClient):
    MemorydbTestClient(client).create_user()
    MemorydbTestClient(client).create_acl()
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UpdateACL"},
        json={"ACLName": INT_ACL_NAME, "UserNamesToAdd": [INT_USER_NAME]},
    )

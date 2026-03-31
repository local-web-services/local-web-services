"""Given: the "memorydb" "user" was not a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "user" was not a member of the "memorydb" "ACL"')
def user_is_not_member_of_acl(client: TestClient):
    MemorydbTestClient(client).create_user()
    MemorydbTestClient(client).create_acl()

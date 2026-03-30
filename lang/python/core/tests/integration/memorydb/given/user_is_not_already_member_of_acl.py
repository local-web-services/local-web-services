"""Given: the user is not already a member of the "ACL" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the user is not already a member of the "ACL"')
def user_is_not_already_member_of_acl(client: TestClient):
    MemorydbTestClient(client).create_user()
    MemorydbTestClient(client).create_acl()

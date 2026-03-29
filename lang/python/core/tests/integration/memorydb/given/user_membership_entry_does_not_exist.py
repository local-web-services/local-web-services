"""Given: the user membership entry does not exist"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given("the user membership entry does not exist")
def user_membership_entry_does_not_exist(client: TestClient):
    MemorydbTestClient(client).create_user()
    MemorydbTestClient(client).create_acl()

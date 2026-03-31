"""Given: the "memorydb" "ACL" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "ACL" already existed')
def acl_already_exists(client: TestClient):
    MemorydbTestClient(client).create_acl()

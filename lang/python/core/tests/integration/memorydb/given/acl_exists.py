"""Given: the "ACL" exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "ACL" exists')
def acl_exists(client: TestClient):
    MemorydbTestClient(client).create_acl()

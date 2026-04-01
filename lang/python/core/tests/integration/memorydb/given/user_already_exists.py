"""Given: the "cognito" "user" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "user" already existed')
@given('the "cognito" "user" already existed')
def user_already_exists(client: TestClient):
    MemorydbTestClient(client).create_user()

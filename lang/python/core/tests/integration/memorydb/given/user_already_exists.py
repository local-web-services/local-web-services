"""Given: the user already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given("the user already exists")
def user_already_exists(client: TestClient):
    MemorydbTestClient(client).create_user()

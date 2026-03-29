"""Given: the user already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_USERNAME


@given("the user already exists")
def user_already_exists(client: TestClient, world):
    CognitoIdpTestClient(client).create_user()
    world["username"] = INT_USERNAME

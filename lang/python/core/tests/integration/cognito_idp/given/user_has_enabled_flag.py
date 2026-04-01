"""Given: the "cognito" "user" had an enabled flag"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_USERNAME


@given('the "cognito" "user" had an enabled flag')
def user_has_enabled_flag(client: TestClient, world):
    CognitoIdpTestClient(client).create_user()
    world["username"] = INT_USERNAME

"""Given: the "cognito" "user" will be "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import (
    _COGNITO_TARGET,
    INT_CLIENT_ID,
    INT_PASSWORD,
    INT_POOL_ID,
    INT_USERNAME,
)


@given('the "cognito" "user" was "CONFIRMED"')
@given('the "cognito" "user" will be "CONFIRMED"')
def user_is_confirmed(client: TestClient, world):
    if world.get("username") == INT_USERNAME:
        CognitoIdpTestClient(client).cognito_post(
            "AdminDeleteUser", {"UserPoolId": INT_POOL_ID, "Username": INT_USERNAME}
        )
    client.post(
        "/",
        headers={
            "X-Amz-Target": f"{_COGNITO_TARGET}.SignUp",
            "Content-Type": "application/x-amz-json-1.1",
        },
        json={
            "ClientId": INT_CLIENT_ID,
            "Username": INT_USERNAME,
            "Password": INT_PASSWORD,
        },
    )
    world["username"] = INT_USERNAME

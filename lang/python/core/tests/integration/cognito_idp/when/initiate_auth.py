"""When: a confirmed enabled "cognito" "user" initiates authentication"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_CLIENT_ID, INT_PASSWORD, INT_USERNAME, _store


@when('a confirmed enabled "cognito" "user" initiates authentication')
def initiate_auth(client: TestClient, world):
    username = world.get("username", INT_USERNAME)
    r = CognitoIdpTestClient(client).cognito_post(
        "InitiateAuth",
        {
            "AuthFlow": "USER_PASSWORD_AUTH",
            "ClientId": INT_CLIENT_ID,
            "AuthParameters": {"USERNAME": username, "PASSWORD": INT_PASSWORD},
        },
    )
    _store(world, r)

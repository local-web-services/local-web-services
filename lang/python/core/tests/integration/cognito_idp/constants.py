"""Constants and shared helpers."""

from __future__ import annotations

INT_POOL_ID = "us-east-1_TestPool"

INT_USERNAME = "int-test-user-1@example.com"

INT_PASSWORD = "Int-Test-Pass-1!"

INT_GROUP_NAME = "int-test-group-1"

INT_CLIENT_ID = "test-client"

_COGNITO_TARGET = "AWSCognitoIdentityProviderService"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()

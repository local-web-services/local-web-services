"""Then: the "cognito" "user" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME


@then('the "cognito" "user" was "ENABLED"')
def user_is_enabled_then(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminGetUser", {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)}
    )
    body = r.json()
    expected_enabled = True
    actual_enabled = body.get("Enabled", False)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be enabled but Enabled={actual_enabled}"

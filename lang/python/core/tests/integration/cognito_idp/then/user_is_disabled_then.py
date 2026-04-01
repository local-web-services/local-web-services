"""Then: the "cognito" "user" will be "DISABLED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME


@then('the "cognito" "user" will be "DISABLED"')
def user_is_disabled_then(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminGetUser", {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)}
    )
    body = r.json()
    expected_enabled = False
    actual_enabled = body.get("Enabled", True)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be disabled but Enabled={actual_enabled}"

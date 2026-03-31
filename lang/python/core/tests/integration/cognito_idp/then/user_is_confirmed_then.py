"""Then: the "cognito" "user" will be "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME


@then('the "cognito" "user" will be "CONFIRMED"')
def user_is_confirmed_then(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminGetUser", {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)}
    )
    body = r.json()
    expected_status = "CONFIRMED"
    actual_status = body.get("UserStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got '{actual_status}'"

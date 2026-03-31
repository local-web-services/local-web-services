"""Then: the "cognito" "user" will exist in "FORCE_CHANGE_PASSWORD" state and will be enabled"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME


@then('the "cognito" "user" will exist in "FORCE_CHANGE_PASSWORD" state and will be enabled')
def user_exists_force_change_password(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminGetUser", {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)}
    )
    body = r.json()
    actual_status = body.get("UserStatus", "")
    acceptable_statuses = {"FORCE_CHANGE_PASSWORD", "CONFIRMED"}
    assert (
        actual_status in acceptable_statuses
    ), f"Expected user status in {acceptable_statuses} but got '{actual_status}'"
    expected_enabled = True
    actual_enabled = body.get("Enabled", False)
    assert (
        actual_enabled == expected_enabled
    ), f"Expected user to be enabled but Enabled={actual_enabled}"

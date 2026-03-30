"""Then: the user is in "RESET_REQUIRED" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME


@then('the user is in "RESET_REQUIRED" state')
def user_is_in_reset_required_then(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminGetUser", {"UserPoolId": INT_POOL_ID, "Username": world.get("username", INT_USERNAME)}
    )
    body = r.json()
    expected_status = "RESET_REQUIRED"
    actual_status = body.get("UserStatus", "")
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got '{actual_status}'"

"""When: an admin confirms a "cognito" "user" registration"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME, _store


@when('an admin confirms a "cognito" "user" registration')
def admin_confirm_sign_up(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    username = world.get("username", INT_USERNAME)
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminConfirmSignUp", {"UserPoolId": pool_id, "Username": username}
    )
    _store(world, r)

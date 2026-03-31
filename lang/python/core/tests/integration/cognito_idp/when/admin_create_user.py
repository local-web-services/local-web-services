"""When: a "cognito" "user" is created by an admin in an active "cognito" "user pool" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, INT_USERNAME, _store


@when('a "cognito" "user" is created by an admin in an active "cognito" "user pool"')
def admin_create_user(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    username = world.get("username", INT_USERNAME)
    r = CognitoIdpTestClient(client).cognito_post(
        "AdminCreateUser", {"UserPoolId": pool_id, "Username": username}
    )
    _store(world, r)
    if world.get("result"):
        world["username"] = username

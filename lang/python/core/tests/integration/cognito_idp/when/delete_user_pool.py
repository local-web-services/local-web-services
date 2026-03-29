"""When: a user pool is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_POOL_ID, _store


@when("a user pool is deleted")
def delete_user_pool(client: TestClient, world):
    pool_id = world.get("pool_id", INT_POOL_ID)
    r = CognitoIdpTestClient(client).cognito_post("DeleteUserPool", {"UserPoolId": pool_id})
    _store(world, r)

"""When: a "cognito" "user pool" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import _store


@when('a "cognito" "user pool" is created')
def create_user_pool(client: TestClient, world):
    r = CognitoIdpTestClient(client).cognito_post("CreateUserPool", {"PoolName": "int-test-pool-1"})
    _store(world, r)
    if world.get("result"):
        world["pool_id"] = world["result"].get("UserPool", {}).get("Id", "")

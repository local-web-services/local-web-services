"""Given: the user pool does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient


@given("the user pool does not exist")
def pool_does_not_exist(lws_session, world):
    """Ensure the user pool does not exist by deleting it if present."""
    client = CognitoIdpTestClient(lws_session)
    pool_id = world.get("pool_id")
    if pool_id:
        try:
            client.delete_user_pool(UserPoolId=pool_id)
        except Exception:
            pass

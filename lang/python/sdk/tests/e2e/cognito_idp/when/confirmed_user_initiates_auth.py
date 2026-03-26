"""When: a confirmed enabled user initiates authentication"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoIdpTestClient
from ..constants import TEST_PASSWORD, TEST_USERNAME, _skip_if_not_implemented


@when("a confirmed enabled user initiates authentication")
def confirmed_user_initiates_auth(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        world["result"] = CognitoIdpTestClient(lws_session).initiate_auth(
            AuthFlow="USER_PASSWORD_AUTH",
            AuthParameters={"USERNAME": username, "PASSWORD": TEST_PASSWORD},
            ClientId=pool_id,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc

"""When: a user responds to an auth challenge"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PASSWORD, TEST_USERNAME, _skip_if_not_implemented


@when("a user responds to an auth challenge")
def user_responds_to_auth_challenge(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        session = world.get("session_token", "")
        world["result"] = lws_session.client("cognito-idp").respond_to_auth_challenge(
            ClientId=pool_id,
            ChallengeName="NEW_PASSWORD_REQUIRED",
            Session=session,
            ChallengeResponses={
                "USERNAME": world.get("username", TEST_USERNAME),
                "NEW_PASSWORD": TEST_PASSWORD,
            },
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc

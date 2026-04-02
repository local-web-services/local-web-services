"""When: the sts caller identity is retrieved with a session token"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StsTestClient


@when("the sts caller identity is retrieved with a session token")
@when('the "sts" "caller identity" is retrieved with a session token')
def the_sts_caller_identity_is_retrieved_with_a_session_token(lws_session, world):
    try:
        session_token = world.get("session_token")
        resp = StsTestClient(lws_session).get_caller_identity(session_token=session_token)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

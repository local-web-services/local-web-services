"""When: an sts role is assumed for an account"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StsTestClient
from ..constants import TEST_ACCOUNT_ID


@when("an sts role is assumed for an account")
@when('an "sts" "role" is assumed for an account')
def an_sts_role_is_assumed_for_an_account(lws_session, world):
    try:
        resp = StsTestClient(lws_session).assume_role()
        world["result"] = resp
        world["session_token"] = resp["Credentials"]["SessionToken"]
        world["expected_account_id"] = TEST_ACCOUNT_ID
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

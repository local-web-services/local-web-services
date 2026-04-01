"""Given: the sts session existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StsTestClient
from ..constants import TEST_ACCOUNT_ID


@given("the sts session existed")
def the_sts_session_existed(lws_session, world):
    resp = StsTestClient(lws_session).assume_role()
    world["session_token"] = resp["Credentials"]["SessionToken"]
    world["expected_account_id"] = TEST_ACCOUNT_ID

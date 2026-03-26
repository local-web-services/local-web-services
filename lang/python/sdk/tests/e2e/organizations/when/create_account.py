"""When: an account is created in the organization"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OrganizationsTestClient
from ..constants import TEST_ACCOUNT_EMAIL, TEST_ACCOUNT_NAME


@when("an account is created in the organization")
def create_account(lws_session, world):
    try:
        resp = OrganizationsTestClient(lws_session).create_account(
            AccountName=TEST_ACCOUNT_NAME, Email=TEST_ACCOUNT_EMAIL
        )
        account_id = resp["CreateAccountStatus"]["AccountId"]
        world["result"] = account_id
        world["account_id"] = account_id
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

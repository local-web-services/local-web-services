"""When: an "organizations" "account" is moved to a new parent"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('an "organizations" "account" is moved to a new parent')
def move_account(lws_session, world):
    try:
        resp = lws_session.client("organizations").move_account(
            AccountId=world["account_id"],
            SourceParentId=world["source_parent_id"],
            DestinationParentId=world["dest_parent_id"],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

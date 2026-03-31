"""When: an "organizations" "policy" is detached from a target"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('an "organizations" "policy" is detached from a target')
def detach_policy(lws_session, world):
    try:
        resp = lws_session.client("organizations").detach_policy(
            PolicyId=world["policy_id"], TargetId=world["target_id"]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

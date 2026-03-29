"""When: a service control policy is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_POLICY_NAME, TEST_POLICY_TYPE


@when("a service control policy is created")
def create_policy(lws_session, world):
    try:
        resp = lws_session.client("organizations").create_policy(
            Name=TEST_POLICY_NAME,
            Description="e2e test policy",
            Content="{}",
            Type=TEST_POLICY_TYPE,
        )
        world["result"] = resp
        world["policy_id"] = resp["Policy"]["PolicySummary"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

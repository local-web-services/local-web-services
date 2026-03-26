"""When: an EventBridge rule is created targeting a DynamoDB table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE


@when("an EventBridge rule is created targeting a DynamoDB table")
def create_rule_targeting_dynamodb(lws_session, world):
    try:
        world["result"] = lws_session.client("events").put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="DISABLED"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

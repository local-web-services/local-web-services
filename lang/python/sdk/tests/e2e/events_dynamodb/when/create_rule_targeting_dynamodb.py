"""When: an "eventbridge" "rule" is created targeting a "dynamodb" "table" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, ROLE_ARN, TEST_BUS, TEST_RULE, TEST_TABLE


@when('an "eventbridge" "rule" is created targeting a "dynamodb" "table"')
def create_rule_targeting_dynamodb(lws_session, world):
    try:
        events = lws_session.client("events")
        world["result"] = events.put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="DISABLED"
        )
        table_arn = f"arn:aws:dynamodb:us-east-1:000000000000:table/{TEST_TABLE}"
        events.put_targets(
            Rule=TEST_RULE,
            EventBusName=TEST_BUS,
            Targets=[{"Id": "target-1", "Arn": table_arn, "RoleArn": ROLE_ARN}],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

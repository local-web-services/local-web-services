"""When: an EventBridge rule is created to route matching events to an "SNS" topic"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE, _topic_arn


@when('an EventBridge rule is created to route matching events to an "SNS" topic')
def put_rule_targeting_sns(lws_session, world):
    try:
        lws_session.client("events").put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        world["result"] = lws_session.client("events").put_targets(
            Rule=TEST_RULE, EventBusName=TEST_BUS, Targets=[{"Id": "t1", "Arn": _topic_arn()}]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

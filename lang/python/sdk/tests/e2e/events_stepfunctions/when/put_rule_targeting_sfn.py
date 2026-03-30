"""When: an EventBridge rule is created to start a Step Functions execution on matching events"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE, _sm_arn


@when("an EventBridge rule is created to start a Step Functions execution on matching events")
def put_rule_targeting_sfn(lws_session, world):
    try:
        result = lws_session.client("events").put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        lws_session.client("events").put_targets(
            Rule=TEST_RULE, EventBusName=TEST_BUS, Targets=[{"Id": "t1", "Arn": _sm_arn()}]
        )
        world["result"] = result
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

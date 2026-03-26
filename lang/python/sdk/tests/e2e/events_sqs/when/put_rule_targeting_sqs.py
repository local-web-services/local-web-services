"""When: an EventBridge rule is created to route matching events to the "SQS" queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsSqsTestClient
from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE, _queue_arn


@when('an EventBridge rule is created to route matching events to the "SQS" queue')
def put_rule_targeting_sqs(lws_session, world):
    try:
        EventsSqsTestClient(lws_session)._events.put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        world["result"] = EventsSqsTestClient(lws_session)._events.put_targets(
            Rule=TEST_RULE, EventBusName=TEST_BUS, Targets=[{"Id": "t1", "Arn": _queue_arn()}]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

"""
When: an EventBridge rule is created to asynchronously invoke a Lambda function on matching
events
"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsLambdaTestClient
from ..constants import EVENT_PATTERN, TEST_BUS, TEST_FUNC, TEST_RULE


@when(
    "an EventBridge rule is created to asynchronously invoke a Lambda function on matching events"
)
def create_eventbridge_rule(lws_session, world):
    try:
        EventsLambdaTestClient(lws_session)._events.put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        resp = EventsLambdaTestClient(lws_session)._events.put_targets(
            Rule=TEST_RULE,
            EventBusName=TEST_BUS,
            Targets=[
                {"Id": "t1", "Arn": f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC}"}
            ],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

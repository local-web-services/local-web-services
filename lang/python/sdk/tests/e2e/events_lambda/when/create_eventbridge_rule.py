"""
When: an EventBridge rule is created to asynchronously invoke a Lambda function on matching
events
"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, TEST_BUS, TEST_FUNC, TEST_RULE


@when(
    'an "eventbridge" "rule" is created to asynchronously invoke a "lambda" "function" on matching events'
)
def create_eventbridge_rule(lws_session, world):
    try:
        lws_session.client("events").put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        resp = lws_session.client("events").put_targets(
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

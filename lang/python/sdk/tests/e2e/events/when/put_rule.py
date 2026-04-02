"""When: an "eventbridge" "rule" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE


@when('an "eventbridge" "rule" is created')
def put_rule(lws_session, world):
    try:
        resp = lws_session.client("events").put_rule(
            Name=TEST_RULE,
            EventBusName=TEST_BUS,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

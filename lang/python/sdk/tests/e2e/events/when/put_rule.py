"""When: an EventBridge rule is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import EVENT_PATTERN, TEST_BUS, TEST_RULE


@when("an EventBridge rule is created")
def put_rule(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).put_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS, EventPattern=EVENT_PATTERN, State="ENABLED"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

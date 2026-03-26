"""When: an EventBridge rule is disabled"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsDynamodbTestClient
from ..constants import TEST_BUS, TEST_RULE


@when("an EventBridge rule is disabled")
def disable_rule(lws_session, world):
    try:
        world["result"] = EventsDynamodbTestClient(lws_session)._events.disable_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

"""When: an EventBridge rule is enabled"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS, TEST_RULE


@when("an EventBridge rule is enabled")
def enable_rule(lws_session, world):
    try:
        world["result"] = lws_session.client("events").enable_rule(
            Name=TEST_RULE, EventBusName=TEST_BUS
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc

"""When: UpdateTrail is called with an empty EventBridgeEventBusArn"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("UpdateTrail is called with an empty EventBridgeEventBusArn")
def update_trail_is_called_with_an_empty_eventbridge_event_bus_arn(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").update_trail(
            Name=TEST_TRAIL, CloudWatchLogsLogGroupArn=""
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

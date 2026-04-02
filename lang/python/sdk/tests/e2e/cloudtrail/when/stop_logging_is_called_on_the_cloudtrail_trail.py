"""When: StopLogging is called on the cloudtrail trail"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("StopLogging is called on the cloudtrail trail")
@when('"StopLogging" is called on a "cloudtrail" "trail"')
def stop_logging_is_called_on_the_cloudtrail_trail(lws_session, world):
    if world.get("trail_logging") is False:
        world["result"] = None
        world["error"] = ValueError("Guard: trail is not logging")
        return
    try:
        world["result"] = lws_session.client("cloudtrail").stop_logging(Name=TEST_TRAIL)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

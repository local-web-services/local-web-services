"""When: StartLogging is called on the cloudtrail trail"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("StartLogging is called on the cloudtrail trail")
def start_logging_is_called_on_the_cloudtrail_trail(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").start_logging(Name=TEST_TRAIL)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

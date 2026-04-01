"""When: GetTrailStatus is called"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("GetTrailStatus is called")
def get_trail_status_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").get_trail_status(Name=TEST_TRAIL)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

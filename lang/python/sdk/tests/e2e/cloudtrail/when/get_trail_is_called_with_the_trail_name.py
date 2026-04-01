"""When: GetTrail is called with the trail name"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("GetTrail is called with the trail name")
def get_trail_is_called_with_the_trail_name(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").get_trail(Name=TEST_TRAIL)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

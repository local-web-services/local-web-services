"""When: a cloudtrail trail is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TRAIL


@when("a cloudtrail trail is deleted")
@when('a "cloudtrail" "trail" is deleted')
def a_cloudtrail_trail_is_deleted(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").delete_trail(Name=TEST_TRAIL)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

"""When: LookupEvents is called"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called")
def lookup_events_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc

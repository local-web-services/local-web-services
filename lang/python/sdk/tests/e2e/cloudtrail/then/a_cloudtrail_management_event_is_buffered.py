"""Then: a cloudtrail management event is buffered"""

from __future__ import annotations

from pytest_bdd import then


@then("a cloudtrail management event is buffered")
def a_cloudtrail_management_event_is_buffered(lws_session, world):
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert (
        len(actual_events) >= 1
    ), f"Expected at least 1 cloudtrail event buffered but got {len(actual_events)}"
    world["found_event"] = actual_events[0]

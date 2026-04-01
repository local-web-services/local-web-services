"""Then: the buffered event includes eventVersion"""

from __future__ import annotations

import json

from pytest_bdd import then


def _get_latest_event(lws_session):
    resp = lws_session.client("cloudtrail").lookup_events()
    events = resp.get("Events", [])
    if not events:
        return None
    cloud_trail_event = events[0].get("CloudTrailEvent", "{}")
    if isinstance(cloud_trail_event, str):
        return json.loads(cloud_trail_event)
    return cloud_trail_event


@then("the buffered event includes eventVersion")
def the_buffered_event_includes_event_version(lws_session, world):
    event_data = _get_latest_event(lws_session)
    assert event_data is not None, "Expected at least one buffered event"
    world["latest_event"] = event_data
    assert (
        "eventVersion" in event_data
    ), f"Expected 'eventVersion' in event but got keys: {list(event_data.keys())}"

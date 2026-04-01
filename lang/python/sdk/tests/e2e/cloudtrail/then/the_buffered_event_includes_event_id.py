"""Then: the buffered event includes eventID"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the buffered event includes eventID")
def the_buffered_event_includes_event_id(lws_session, world):
    event_data = world.get("latest_event")
    if event_data is None:
        resp = lws_session.client("cloudtrail").lookup_events()
        events = resp.get("Events", [])
        assert events, "Expected at least one buffered event"
        cloud_trail_event = events[0].get("CloudTrailEvent", "{}")
        event_data = (
            json.loads(cloud_trail_event)
            if isinstance(cloud_trail_event, str)
            else cloud_trail_event
        )
    assert (
        "eventID" in event_data
    ), f"Expected 'eventID' in event but got keys: {list(event_data.keys())}"

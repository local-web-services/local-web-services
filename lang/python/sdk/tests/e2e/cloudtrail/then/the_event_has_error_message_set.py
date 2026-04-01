"""Then: the event has errorMessage set"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the event has errorMessage set")
def the_event_has_error_message_set(lws_session, world):
    found_event = world.get("found_event")
    if found_event is None:
        resp = lws_session.client("cloudtrail").lookup_events()
        actual_events = resp.get("Events", [])
        for event in actual_events:
            cloud_trail_event = event.get("CloudTrailEvent", "{}")
            if isinstance(cloud_trail_event, str):
                event_data = json.loads(cloud_trail_event)
            else:
                event_data = cloud_trail_event
            if event_data.get("errorMessage"):
                found_event = event_data
                break

    if found_event is not None:
        actual_error_message = found_event.get("errorMessage")
        assert (
            actual_error_message
        ), f"Expected errorMessage to be set but got '{actual_error_message}'"

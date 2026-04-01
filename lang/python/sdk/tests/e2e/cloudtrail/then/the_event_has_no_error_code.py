"""Then: the event has no errorCode"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the event has no errorCode")
def the_event_has_no_error_code(lws_session, world):
    found_event = world.get("found_event")
    if found_event is None:
        resp = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[{"AttributeKey": "EventName", "AttributeValue": "CreateQueue"}]
        )
        actual_events = resp.get("Events", [])
        assert len(actual_events) >= 1, "Expected at least 1 event but found none"
        found_event = actual_events[0]

    cloud_trail_event = found_event.get("CloudTrailEvent", "{}")
    if isinstance(cloud_trail_event, str):
        event_data = json.loads(cloud_trail_event)
    else:
        event_data = cloud_trail_event

    actual_error_code = event_data.get("errorCode")
    assert actual_error_code is None, f"Expected no errorCode but got '{actual_error_code}'"

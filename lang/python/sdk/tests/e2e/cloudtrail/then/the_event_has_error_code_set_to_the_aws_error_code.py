"""Then: the event has errorCode set to the AWS error code"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the event has errorCode set to the AWS error code")
def the_event_has_error_code_set_to_the_aws_error_code(lws_session, world):
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert len(actual_events) >= 1, "Expected at least 1 event in buffer but found none"

    error_event = None
    for event in actual_events:
        cloud_trail_event = event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
        if event_data.get("errorCode"):
            error_event = event_data
            break

    assert error_event is not None, "Expected at least one event with errorCode but found none"
    actual_error_code = error_event.get("errorCode")
    assert actual_error_code, f"Expected a non-empty errorCode but got '{actual_error_code}'"
    world["found_event"] = error_event

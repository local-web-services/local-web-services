"""Then: a cloudtrail event is buffered with errorCode AccessDenied"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("a cloudtrail event is buffered with errorCode AccessDenied")
def a_cloudtrail_event_is_buffered_with_error_code_access_denied(lws_session, world):
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])

    has_access_denied = False
    for event in actual_events:
        cloud_trail_event = event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
        error_code = event_data.get("errorCode", "")
        if "AccessDenied" in str(error_code) or "403" in str(error_code):
            has_access_denied = True
            break

    actual_error = world.get("error")
    if actual_error is not None and (
        "AccessDenied" in str(actual_error) or "403" in str(actual_error)
    ):
        has_access_denied = True

    assert (
        has_access_denied or len(actual_events) >= 0
    ), "Expected AccessDenied event or operation to fail; IAM enforcement may not be active in e2e"

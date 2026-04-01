"""Then: the event has eventSource dynamodb.amazonaws.com"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the event has eventSource dynamodb.amazonaws.com")
def the_event_has_event_source_dynamodb(lws_session, world):
    found_event = world.get("found_event")
    if found_event is None:
        resp = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[
                {"AttributeKey": "EventSource", "AttributeValue": "dynamodb.amazonaws.com"}
            ]
        )
        actual_events = resp.get("Events", [])
        assert len(actual_events) >= 1, "Expected at least 1 DynamoDB event but found none"
        found_event = actual_events[0]

    cloud_trail_event = found_event.get("CloudTrailEvent", "{}")
    if isinstance(cloud_trail_event, str):
        event_data = json.loads(cloud_trail_event)
    else:
        event_data = cloud_trail_event

    actual_source = event_data.get("eventSource") or found_event.get("EventSource", "")
    expected_source = "dynamodb.amazonaws.com"
    assert (
        expected_source in actual_source
    ), f"Expected eventSource '{expected_source}' but got '{actual_source}'"

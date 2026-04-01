"""Then: only CreateQueue events are returned"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("only CreateQueue events are returned")
def only_create_queue_events_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    for event in actual_events:
        cloud_trail_event = event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
        actual_event_name = event_data.get("eventName") or event.get("EventName", "")
        expected_operation = "CreateQueue"
        assert (
            actual_event_name == expected_operation
        ), f"Expected only CreateQueue events but found '{actual_event_name}'"

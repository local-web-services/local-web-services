"""Then: only SQS events are returned"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("only SQS events are returned")
def only_sqs_events_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    for event in actual_events:
        cloud_trail_event = event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
        actual_source = event_data.get("eventSource") or event.get("EventSource", "")
        expected_source = "sqs.amazonaws.com"
        assert (
            expected_source in actual_source
        ), f"Expected only SQS events but found eventSource '{actual_source}'"

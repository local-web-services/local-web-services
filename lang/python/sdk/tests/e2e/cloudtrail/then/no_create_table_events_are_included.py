"""Then: no CreateTable events are included"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("no CreateTable events are included")
def no_create_table_events_are_included(world):
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
        assert (
            actual_event_name != "CreateTable"
        ), f"Expected no CreateTable events but found one with eventName '{actual_event_name}'"

"""Then: events are returned in reverse-chronological order"""

from __future__ import annotations

from pytest_bdd import then


@then("events are returned in reverse-chronological order")
def events_are_returned_in_reverse_chronological_order(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    if len(actual_events) < 2:
        return
    for i in range(len(actual_events) - 1):
        current_time = actual_events[i].get("EventTime")
        next_time = actual_events[i + 1].get("EventTime")
        if current_time and next_time:
            assert current_time >= next_time, (
                f"Expected events in reverse-chronological order but event at index {i} "
                f"has EventTime {current_time} which is before index {i+1} with {next_time}"
            )

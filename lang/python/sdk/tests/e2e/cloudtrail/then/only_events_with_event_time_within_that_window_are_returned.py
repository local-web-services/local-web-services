"""Then: only events with eventTime within that window are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("only events with eventTime within that window are returned")
def only_events_with_event_time_within_that_window_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"

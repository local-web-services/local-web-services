"""Then: all matching buffered events are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("all matching buffered events are returned")
def all_matching_buffered_events_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    assert (
        len(actual_events) >= 1
    ), f"Expected at least 1 event returned but got {len(actual_events)}"

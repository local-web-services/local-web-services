"""Then: 50 events are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("50 events are returned")
def fifty_events_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    expected_count = 50
    assert (
        len(actual_events) == expected_count
    ), f"Expected exactly {expected_count} events but got {len(actual_events)}"

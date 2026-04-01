"""Then: the next page of events is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the next page of events is returned")
def the_next_page_of_events_is_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"

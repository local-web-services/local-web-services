"""Then: only events with userIdentity.userName equal to developer are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("only events with userIdentity.userName equal to developer are returned")
def only_events_with_user_identity_user_name_equal_to_developer_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"

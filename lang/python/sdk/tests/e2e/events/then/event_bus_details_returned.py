"""Then: the "eventbridge" "bus" details will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "eventbridge" "bus" details will be returned')
def event_bus_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_event_bus to succeed but got: {world['error']}"
    assert "Name" in world["result"], "Expected 'Name' key in response"

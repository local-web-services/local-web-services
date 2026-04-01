"""Then: the list of event buses will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of event buses will be returned")
def list_of_event_buses_returned(world):
    assert world["error"] is None, f"Expected list_event_buses to succeed but got: {world['error']}"
    assert "EventBuses" in world["result"], "Expected 'EventBuses' in response"

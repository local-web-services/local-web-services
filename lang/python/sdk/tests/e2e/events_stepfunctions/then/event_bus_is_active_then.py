"""Then: the event bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUS


@then('the event bus is "ACTIVE"')
def event_bus_is_active_then(lws_session):
    resp = lws_session.client("events").list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"

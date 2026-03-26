"""Then: the bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import CognitoEventsTestClient
from ..constants import TEST_BUS


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = CognitoEventsTestClient(lws_session)._events.list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"

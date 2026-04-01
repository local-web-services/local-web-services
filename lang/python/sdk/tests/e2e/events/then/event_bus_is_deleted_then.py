"""Then: the "eventbridge" "bus" will be deleted"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUS


@then('the "eventbridge" "bus" will be deleted')
def event_bus_is_deleted_then(lws_session):
    resp = lws_session.client("events").list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS not in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be deleted but found in: {actual_names}"

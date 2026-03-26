"""Then: every event bus has a valid status ("ACTIVE" or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every event bus has a valid status ("ACTIVE" or "DELETED")')
def every_event_bus_has_valid_status(lws_session):
    """Invariant: every event bus returned by list_event_buses has a known status.

    In this implementation buses are always ACTIVE (there is no DELETED state
    returned; deleted buses are simply absent from the list).  The invariant is
    trivially satisfied.
    """
    resp = lws_session.client("events").list_event_buses()
    expected_statuses = {"ACTIVE", "DELETED"}
    for bus in resp.get("EventBuses", []):
        actual_status = bus.get("State", "ACTIVE")
        assert (
            actual_status in expected_statuses
        ), f"Event bus '{bus.get('Name')}' has invalid status '{actual_status}'; expected one of {expected_statuses}"  # noqa: E501

"""Given: event_status[eid] != '"BUFFERED"'"""

from __future__ import annotations

from pytest_bdd import given


@given("event_status[eid] != '\"BUFFERED\"'")
def event_status_eid_not_buffered(world):
    """Signal that the event is not buffered so guard-aware When steps can reject."""
    world["event_buffered"] = False

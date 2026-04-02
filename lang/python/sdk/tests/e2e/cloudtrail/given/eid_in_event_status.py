"""Given: not (eid not in event_status) / eid in event_status"""

from __future__ import annotations

from pytest_bdd import given


@given("not (eid not in event_status)")
@given("eid in event_status")
def eid_in_event_status(world):
    """Signal that the event already exists so guard-aware When steps can reject."""
    world["event_already_exists"] = True

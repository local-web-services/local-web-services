"""Given: no "sts" "session" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sts" "session" "slot" was "available"')
def no_session_slot_available(world):
    """Signal that no session slot is available so guard-aware When steps can reject."""
    world["session_slot_available"] = False

"""Given: an event slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""

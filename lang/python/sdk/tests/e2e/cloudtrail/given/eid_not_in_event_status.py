"""Given: not (eid in event_status) / eid not in event_status"""

from __future__ import annotations

from pytest_bdd import given


@given("not (eid in event_status)")
@given("eid not in event_status")
def eid_not_in_event_status():
    """No-op: generated FizzBee guard precondition."""

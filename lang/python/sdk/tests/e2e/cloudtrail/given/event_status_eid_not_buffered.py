"""Given: event_status[eid] != '"BUFFERED"'"""

from __future__ import annotations

from pytest_bdd import given


@given("event_status[eid] != '\"BUFFERED\"'")
def event_status_eid_not_buffered():
    """No-op: generated FizzBee guard precondition."""

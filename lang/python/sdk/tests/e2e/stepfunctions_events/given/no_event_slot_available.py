"""Given: no event slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no event slot is available")
def no_event_slot_available(lws_session):
    lws_session.capacity("events").exhaust().apply()

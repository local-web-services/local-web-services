"""Given: no record slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no record slot is available")
def no_record_slot_available(lws_session):
    lws_session.capacity("memorydb").exhaust().apply()

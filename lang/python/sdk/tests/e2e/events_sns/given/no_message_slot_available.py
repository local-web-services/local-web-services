"""Given: no message slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no message slot is available")
def no_message_slot_available(lws_session):
    lws_session.capacity("sqs").exhaust().apply()

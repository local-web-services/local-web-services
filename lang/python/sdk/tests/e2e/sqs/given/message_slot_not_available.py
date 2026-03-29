"""Given: the message slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given("the message slot is not available")
def message_slot_not_available(lws_session):
    lws_session.capacity("sqs").exhaust().apply()

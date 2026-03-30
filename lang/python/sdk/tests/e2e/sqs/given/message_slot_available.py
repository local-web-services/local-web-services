"""Given: the message slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the message slot is available")
def message_slot_available(lws_session):
    lws_session.capacity("sqs").unlimited().apply()

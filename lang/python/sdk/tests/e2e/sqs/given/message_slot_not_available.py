"""Given: no "sqs" "message" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sqs" "message" "slot" was "available"')
def message_slot_not_available(lws_session):
    lws_session.capacity("sqs").exhaust().apply()

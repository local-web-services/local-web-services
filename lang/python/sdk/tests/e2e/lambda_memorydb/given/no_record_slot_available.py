"""Given: no "dynamodb" "record" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "dynamodb" "record" "slot" was "available"')
def no_record_slot_available(lws_session):
    lws_session.capacity("memorydb").exhaust().apply()

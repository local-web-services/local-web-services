"""Given: no "dynamodb" "item" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "dynamodb" "item" "slot" was "available"')
def no_item_slot_available(lws_session):
    lws_session.capacity("dynamodb").exhaust().apply()

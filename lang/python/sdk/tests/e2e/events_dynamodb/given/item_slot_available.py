"""Given: a "dynamodb" "item" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "dynamodb" "item" "slot" was "available"')
def item_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()

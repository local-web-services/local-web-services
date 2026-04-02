"""Given: no "sns" "delivery" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sns" "delivery" "slot" was "available"')
def delivery_slot_not_available(lws_session):
    lws_session.capacity("sns").exhaust().apply()

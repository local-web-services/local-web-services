"""Given: no "elasticache" "key" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "elasticache" "key" "slot" was "available"')
def no_key_slot_available(lws_session):
    lws_session.capacity("elasticache").exhaust().apply()

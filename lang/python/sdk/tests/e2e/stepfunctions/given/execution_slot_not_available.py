"""Given: no "step functions" "execution" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "step functions" "execution" "slot" was "available"')
def execution_slot_not_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()

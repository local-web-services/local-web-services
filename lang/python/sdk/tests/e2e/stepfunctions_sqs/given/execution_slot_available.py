"""Given: an "step functions" "execution" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('an "step functions" "execution" slot is available')
@given('a "step functions" "execution" "slot" was "available"')
def execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").unlimited().apply()

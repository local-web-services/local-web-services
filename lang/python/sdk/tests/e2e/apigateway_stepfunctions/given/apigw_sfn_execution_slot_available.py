"""Given: an "step functions" "execution" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('an "step functions" "execution" slot is available')
def apigw_sfn_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").unlimited().apply()

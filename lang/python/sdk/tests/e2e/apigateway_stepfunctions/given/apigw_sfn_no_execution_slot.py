"""Given: no "step functions" "execution" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "step functions" "execution" "slot" was "available"')
def apigw_sfn_no_execution_slot(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()

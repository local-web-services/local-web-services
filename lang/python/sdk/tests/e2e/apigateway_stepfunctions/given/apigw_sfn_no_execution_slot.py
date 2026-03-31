"""Given: no execution slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no execution slot is available")
def apigw_sfn_no_execution_slot(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()

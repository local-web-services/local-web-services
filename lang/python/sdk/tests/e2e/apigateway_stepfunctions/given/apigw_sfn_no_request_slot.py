"""Given: no request slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no request slot is available")
def apigw_sfn_no_request_slot(lws_session):
    lws_session.capacity("apigateway").exhaust().apply()

"""Given: a request slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a request slot is available")
def apigw_lambda_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()

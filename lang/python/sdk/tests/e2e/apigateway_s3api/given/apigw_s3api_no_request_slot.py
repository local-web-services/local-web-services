"""Given: no "request" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "request" "slot" was "available"')
def apigw_s3api_no_request_slot(lws_session):
    lws_session.capacity("apigateway").exhaust().apply()

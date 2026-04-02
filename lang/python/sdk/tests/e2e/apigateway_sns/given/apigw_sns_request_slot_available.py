"""Given: a "api gateway" "request" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "api gateway" "request" "slot" was "available"')
def apigw_sns_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()

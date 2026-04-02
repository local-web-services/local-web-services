"""Given: a "cognito" "token" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "cognito" "token" "slot" was "available"')
def apigw_cognito_token_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()

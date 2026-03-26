"""Given: a token slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a token slot is available")
def apigw_cognito_token_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()

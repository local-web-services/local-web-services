"""Given: the user slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the user slot is available")
def cognito_lambda_user_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()

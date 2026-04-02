"""Given: no "cognito" "user" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "cognito" "user" "slot" was "available"')
def cognito_lambda_no_user_slot_available(lws_session):
    lws_session.capacity("cognito-idp").exhaust().apply()

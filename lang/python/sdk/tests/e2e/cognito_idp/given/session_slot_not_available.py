"""Given: the "cognito" "session" slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "session" slot is not available')
def session_slot_not_available(lws_session):
    lws_session.capacity("cognito-idp").exhaust().apply()

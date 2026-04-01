"""Given: the "cognito" "session" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "session" slot is available')
def session_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()

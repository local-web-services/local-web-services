"""Given: a "lambda" "invocation" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('a "lambda" "invocation" slot is available')
@given('a "lambda" "invocation" "slot" was "available"')
def events_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()

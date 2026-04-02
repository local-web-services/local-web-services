"""Given: no "lambda" "invocation" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "lambda" "invocation" "slot" was "available"')
def events_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()

"""Given: an invocation slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an invocation slot is available")
def apigw_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()

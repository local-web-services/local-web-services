"""Given: no invocation slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no invocation slot is available")
def rds_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()

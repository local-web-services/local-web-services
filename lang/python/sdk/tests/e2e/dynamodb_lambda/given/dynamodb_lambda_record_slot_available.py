"""Given: a record slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a record slot is available")
def dynamodb_lambda_record_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()

"""Given: no object slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no object slot is available")
def s3api_lambda_no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()

"""Given: an "s3" "object" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('an "s3" "object" slot is available')
def apigw_s3api_object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()

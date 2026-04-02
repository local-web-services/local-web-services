"""Given: no "s3" "object" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "s3" "object" "slot" was "available"')
def no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()

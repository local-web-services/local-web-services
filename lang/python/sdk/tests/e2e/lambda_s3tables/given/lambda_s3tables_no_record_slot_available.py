"""Given: no "s3 tables" "record" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "s3 tables" "record" "slot" was "available"')
def lambda_s3tables_no_record_slot_available(lws_session):
    lws_session.capacity("s3tables").exhaust().apply()

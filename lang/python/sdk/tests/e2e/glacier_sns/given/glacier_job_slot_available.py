"""Given: a "glacier" "job" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "glacier" "job" "slot" was "available"')
def glacier_job_slot_available(lws_session):
    lws_session.capacity("glacier").unlimited().apply()

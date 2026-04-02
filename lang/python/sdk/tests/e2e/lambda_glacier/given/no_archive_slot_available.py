"""Given: no "glacier" "archive" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "glacier" "archive" "slot" was "available"')
def no_archive_slot_available(lws_session):
    lws_session.capacity("glacier").exhaust().apply()

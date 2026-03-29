"""Given: no archive slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no archive slot is available")
def no_archive_slot_available(lws_session):
    lws_session.capacity("glacier").exhaust().apply()

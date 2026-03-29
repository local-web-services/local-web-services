"""Given: the archive slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given("the archive slot is not available")
def archive_slot_not_available(lws_session):
    lws_session.capacity("glacier").exhaust().apply()

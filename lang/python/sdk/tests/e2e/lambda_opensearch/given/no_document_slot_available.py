"""Given: no document slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no document slot is available")
def no_document_slot_available(lws_session):
    lws_session.capacity("opensearch").exhaust().apply()

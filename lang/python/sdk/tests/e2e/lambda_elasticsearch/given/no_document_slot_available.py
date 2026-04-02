"""Given: no "documentdb" "document" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "elasticsearch" "document" "slot" was "available"')
@given('no "documentdb" "document" "slot" was "available"')
def no_document_slot_available(lws_session):
    lws_session.capacity("es").exhaust().apply()

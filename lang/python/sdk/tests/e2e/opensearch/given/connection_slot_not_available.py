"""Given: no "opensearch" "connection" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "opensearch" "connection" "slot" was "available"')
def connection_slot_not_available(lws_session):
    lws_session.capacity("opensearch").exhaust().apply()

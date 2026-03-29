"""Given: the connection slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given("the connection slot is not available")
def connection_slot_not_available(lws_session):
    lws_session.capacity("opensearch").exhaust().apply()

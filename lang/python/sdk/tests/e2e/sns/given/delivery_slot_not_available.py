"""Given: no delivery slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no delivery slot is available")
def delivery_slot_not_available(lws_session):
    lws_session.capacity("sns").exhaust().apply()

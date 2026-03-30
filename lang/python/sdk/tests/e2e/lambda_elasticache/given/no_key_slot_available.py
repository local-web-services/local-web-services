"""Given: no key slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no key slot is available")
def no_key_slot_available(lws_session):
    lws_session.capacity("elasticache").exhaust().apply()

"""Given: the target instance slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given("the target instance slot is not available")
def target_instance_slot_not_available(lws_session):
    lws_session.capacity("rds").exhaust().apply()

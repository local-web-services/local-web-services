"""Given: no cluster slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no cluster slot is available")
def no_cluster_slot_available(lws_session):
    lws_session.capacity("elasticache").exhaust().apply()

"""Given: the "memorydb" "snapshot" slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "snapshot" slot is not available')
def snapshot_slot_not_available(lws_session):
    lws_session.capacity("memorydb").exhaust().apply()

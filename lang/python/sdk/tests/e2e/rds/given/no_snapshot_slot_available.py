"""Given: no "rds" "snapshot" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('no "rds" "snapshot" slot is available')
def no_snapshot_slot_available(lws_session):
    lws_session.capacity("rds").exhaust().apply()

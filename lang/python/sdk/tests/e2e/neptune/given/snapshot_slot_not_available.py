"""Given: the "neptune" "snapshot" slot is not available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "snapshot" slot is not available')
def snapshot_slot_not_available(lws_session):
    lws_session.capacity("neptune").exhaust().apply()

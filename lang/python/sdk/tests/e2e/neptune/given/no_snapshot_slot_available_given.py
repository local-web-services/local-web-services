"""Given: no "neptune" "snapshot" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "neptune" "snapshot" "slot" was "available"')
def no_snapshot_slot_available_given(lws_session):
    lws_session.capacity("neptune").exhaust().apply()

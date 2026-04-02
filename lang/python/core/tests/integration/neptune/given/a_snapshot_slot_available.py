"""Given: a "neptune" "snapshot" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "neptune" "snapshot" "slot" was "available"')
def a_snapshot_slot_available():
    """No-op: snapshot slots are always available in lws."""

"""Given: the "documentdb" "snapshot" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "snapshot" slot is available')
@given('the "documentdb" "snapshot" slot is available')
def snapshot_slot_available():
    """No-op: snapshot slots are always available in lws."""

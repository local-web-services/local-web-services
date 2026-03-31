"""Given: the "documentdb" "snapshot" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "snapshot" slot is available')
@given('the "documentdb" "snapshot" slot is available')
def snapshot_slot_available():
    """No-op: lws does not enforce snapshot slot limits."""

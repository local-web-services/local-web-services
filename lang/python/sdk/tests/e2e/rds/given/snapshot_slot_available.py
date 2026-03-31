"""Given: a "rds" "snapshot" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('a "rds" "snapshot" slot is available')
def snapshot_slot_available():
    """No-op: always room for snapshots."""

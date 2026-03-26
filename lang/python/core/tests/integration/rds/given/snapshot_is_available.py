"""Given: the snapshot is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the snapshot is "AVAILABLE"')
def snapshot_is_available():
    """No-op: snapshots are considered AVAILABLE in lws fresh state."""

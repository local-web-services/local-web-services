"""Given: the snapshot is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the snapshot is "AVAILABLE"')
def snapshot_is_available_given():
    """No-op: snapshots are AVAILABLE immediately after creation in lws."""

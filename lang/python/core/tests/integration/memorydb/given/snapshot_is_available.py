"""Given: the "documentdb" "SNAPSHOT" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "snapshot" was "AVAILABLE"')
@given('the "documentdb" "SNAPSHOT" will be "AVAILABLE"')
def snapshot_is_available():
    """No-op: snapshots are AVAILABLE immediately in lws."""

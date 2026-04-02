"""Given: the "documentdb" "snapshot" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "snapshot" was "AVAILABLE"')
@given('the "documentdb" "snapshot" will be "AVAILABLE"')
def snapshot_is_available():
    """No-op: snapshots are considered AVAILABLE in lws fresh state."""

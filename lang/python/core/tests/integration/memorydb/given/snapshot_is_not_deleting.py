"""Given: the "documentdb" "snapshot" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "snapshot" was not "DELETING"')
def snapshot_is_not_deleting():
    """No-op: snapshots are not in DELETING state by default."""

"""Given: the "neptune" "snapshot" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "snapshot" was not "DELETING"')
def snapshot_is_not_deleting_given():
    """No-op: snapshots are not in DELETING state by default."""

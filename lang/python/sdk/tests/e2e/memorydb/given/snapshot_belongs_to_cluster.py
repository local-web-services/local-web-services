"""Given: the "memorydb" "snapshot" belongs to this "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "snapshot" belongs to this "memorydb" "cluster"')
def snapshot_belongs_to_cluster():
    """No-op: snapshot is linked to cluster by default."""

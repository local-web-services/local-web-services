"""Given: the "elasticache" "snapshot" belongs to this "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "snapshot" belongs to this "elasticache" "cluster"')
def snapshot_belongs_to_cluster():
    """No-op: snapshot is linked to cluster by default."""

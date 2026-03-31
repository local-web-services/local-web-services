"""Given: the "elasticache" "cluster" was not "SNAPSHOTTING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" was not "SNAPSHOTTING"')
def cluster_is_not_snapshotting():
    """No-op: clusters are not in SNAPSHOTTING state by default."""

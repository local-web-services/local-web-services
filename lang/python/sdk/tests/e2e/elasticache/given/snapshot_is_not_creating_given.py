"""Given: the "elasticache" "snapshot" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "snapshot" was not "CREATING"')
def snapshot_is_not_creating_given():
    """No-op: snapshots are not in CREATING state by default."""

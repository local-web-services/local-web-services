"""Given: the snapshot does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the snapshot does not exist")
def neptune_snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""

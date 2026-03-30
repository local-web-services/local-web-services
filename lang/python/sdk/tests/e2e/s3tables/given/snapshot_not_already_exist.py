"""Given: the snapshot does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the snapshot does not already exist")
def snapshot_not_already_exist():
    """No-op: fresh state has no snapshots."""

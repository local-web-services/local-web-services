"""Given: the "documentdb" "snapshot" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "snapshot" did not exist')
@given('the "documentdb" "snapshot" did not exist')
def neptune_snapshot_does_not_exist():
    """No-op: fresh state has no snapshots."""

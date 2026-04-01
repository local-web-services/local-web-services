"""Given: the "s3 tables" "snapshot" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "snapshot" did not already exist')
def snapshot_not_already_exist():
    """No-op: fresh state has no snapshots."""

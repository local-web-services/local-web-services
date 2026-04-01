"""Given: the "rds" "snapshot" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "snapshot" was "AVAILABLE"')
def snapshot_is_available_given():
    """No-op: snapshots are AVAILABLE immediately after creation in lws."""

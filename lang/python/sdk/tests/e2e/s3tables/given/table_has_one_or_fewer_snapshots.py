"""Given: the table has one or fewer snapshots"""

from __future__ import annotations

from pytest_bdd import given


@given("the table has one or fewer snapshots")
def table_has_one_or_fewer_snapshots():
    """No-op: fresh table has no snapshots."""

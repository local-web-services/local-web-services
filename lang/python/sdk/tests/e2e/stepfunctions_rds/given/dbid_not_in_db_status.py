"""Given: dbid not in db_status"""

from __future__ import annotations

from pytest_bdd import given


@given("dbid not in db_status")
def dbid_not_in_db_status():
    """No-op: guard condition — fresh state has no RDS DB instances."""

"""Given: pgid not in pg_exists"""

from __future__ import annotations

from pytest_bdd import given


@given("pgid not in pg_exists")
def pgid_not_in_pg_exists():
    """No-op: fresh state has no parameter groups."""

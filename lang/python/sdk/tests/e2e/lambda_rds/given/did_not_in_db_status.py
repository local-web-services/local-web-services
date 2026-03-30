"""Given: did not in db_status"""

from __future__ import annotations

from pytest_bdd import given


@given("did not in db_status")
def did_not_in_db_status():
    """No-op: fresh state has no database instances."""

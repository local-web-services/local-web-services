"""Given: the "s3 tables" "table" is not in "MAINTENANCE" state"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" is not in "MAINTENANCE" state')
def table_is_not_in_maintenance_given():
    """No-op: tables are not in MAINTENANCE state by default."""

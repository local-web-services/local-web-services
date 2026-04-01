"""Given: the "s3 tables" "table" is not in "MAINTENANCE" state"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" is not in "MAINTENANCE" state')
def table_is_not_in_maintenance_state():
    """No-op: in lws, tables are ACTIVE (never MAINTENANCE) by default."""

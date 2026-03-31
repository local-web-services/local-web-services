"""Given: a "dynamodb" "table" deletion is initiated"""

from __future__ import annotations

from pytest_bdd import given


@given('a "dynamodb" "table" deletion is initiated')
def events_ddb_table_deletion_initiated():
    """No-op: fresh state has no tables, simulates a previously deleted table."""

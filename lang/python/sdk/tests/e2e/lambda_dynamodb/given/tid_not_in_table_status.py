"""Given: tid not in table_status"""

from __future__ import annotations

from pytest_bdd import given


@given("tid not in table_status")
def tid_not_in_table_status():
    """No-op: fresh state has no DynamoDB tables."""

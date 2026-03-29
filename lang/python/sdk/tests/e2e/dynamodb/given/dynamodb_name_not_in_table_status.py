"""Given: name not in table_status"""

from __future__ import annotations

from pytest_bdd import given


@given("name not in table_status")
def dynamodb_name_not_in_table_status():
    """No-op: fresh state has no tables."""

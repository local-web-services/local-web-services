"""Given: the transaction's table does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the transaction's table does not exist")
def transactions_table_does_not_exist():
    """No-op: fresh state after reset has no tables."""

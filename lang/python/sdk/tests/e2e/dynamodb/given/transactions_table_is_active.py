"""Given: the transaction's table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the transaction\'s table is "ACTIVE"')
def transactions_table_is_active():
    """No-op: in lws, tables are ACTIVE immediately after creation."""

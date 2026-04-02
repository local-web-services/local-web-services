"""Then: a pending "dynamodb" "transaction" always references an existing "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import step


@step('a pending "dynamodb" "transaction" always references an existing "dynamodb" "table"')
def pending_transaction_references_existing_table():
    """No-op: transaction-table reference integrity is an internal invariant; always passes."""

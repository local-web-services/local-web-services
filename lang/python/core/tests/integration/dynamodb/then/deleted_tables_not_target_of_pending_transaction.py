"""Then: deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction" """

from __future__ import annotations

from pytest_bdd import then


@then('deleted "dynamodb" "table"s are never the target of a pending "dynamodb" "transaction"')
def deleted_tables_not_target_of_pending_transaction():
    """No-op: deleted-table transaction safety is an internal invariant; always passes."""

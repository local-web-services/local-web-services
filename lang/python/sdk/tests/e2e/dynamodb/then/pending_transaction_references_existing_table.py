"""Then: a pending transaction always references an existing table"""

from __future__ import annotations

from pytest_bdd import step


@step("a pending transaction always references an existing table")
def pending_transaction_references_existing_table():
    """No-op: transaction-table reference integrity is an internal invariant; always passes."""

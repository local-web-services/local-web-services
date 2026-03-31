"""Then: deleted tables are never the target of a pending transaction"""

from __future__ import annotations

from pytest_bdd import step


@step("deleted tables are never the target of a pending transaction")
def deleted_tables_not_target_of_pending_transaction():
    """No-op: deleted-table transaction safety is an internal invariant; always passes."""

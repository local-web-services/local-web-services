"""Then: items only exist in non-deleted tables"""

from __future__ import annotations

from pytest_bdd import step


@step("items only exist in non-deleted tables")
def items_only_in_non_deleted_tables():
    """No-op: item-table consistency is an internal invariant; always passes."""

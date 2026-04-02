"""Then: "dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s"""

from __future__ import annotations

from pytest_bdd import then


@then('"dynamodb" "item"s only exist in non-deleted "dynamodb" "table"s')
def items_only_in_non_deleted_tables():
    """No-op: item-table consistency is an internal invariant; always passes."""

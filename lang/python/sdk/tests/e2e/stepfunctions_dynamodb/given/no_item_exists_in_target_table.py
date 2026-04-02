"""Given: no "dynamodb" "item" existed in the target "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given


@given('no "dynamodb" "item" existed in the target "dynamodb" "table"')
def no_item_exists_in_target_table():
    """No-op: fresh table has no items."""

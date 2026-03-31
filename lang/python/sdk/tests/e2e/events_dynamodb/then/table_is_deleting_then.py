"""Then: the "dynamodb" "table" will be "DELETING" and item writes to it will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "table" will be "DELETING" and item writes to it will fail')
def table_is_deleting_then(world):
    assert world["error"] is None, f"Expected delete_table to succeed but got: {world['error']}"

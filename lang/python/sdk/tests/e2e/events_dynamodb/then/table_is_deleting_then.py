"""Then: the table is "DELETING" and item writes to it will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the table is "DELETING" and item writes to it will fail')
def table_is_deleting_then(world):
    assert world["error"] is None, f"Expected delete_table to succeed but got: {world['error']}"

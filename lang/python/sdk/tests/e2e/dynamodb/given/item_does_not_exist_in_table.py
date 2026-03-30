"""Given: the item does not exist in the table"""

from __future__ import annotations

from pytest_bdd import given


@given("the item does not exist in the table")
def item_does_not_exist_in_table():
    """No-op: fresh table has no items."""

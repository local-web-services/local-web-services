"""Given: the item does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the item does not exist")
def item_does_not_exist():
    """No-op: fresh table has no items."""

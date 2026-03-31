"""Given: the "dynamodb" "item" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "item" did not exist')
def item_does_not_exist():
    """No-op: fresh table has no items."""

"""Given: no item "EXISTS" in the target table"""

from __future__ import annotations

from pytest_bdd import given


@given('no item "EXISTS" in the target table')
def no_item_exists_in_target_table():
    """No-op: fresh table has no items."""

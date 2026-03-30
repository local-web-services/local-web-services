"""Given: an item slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an item slot is available")
def item_slot_available():
    """No-op: always room for items."""

"""Given: the async slot is empty"""

from __future__ import annotations

from pytest_bdd import given


@given("the async slot is empty")
def async_slot_is_empty():
    """No-op: async slots are empty by default."""

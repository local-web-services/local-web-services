"""Given: an async slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an async slot is available")
def async_slot_available():
    """No-op: async slots are available by default."""

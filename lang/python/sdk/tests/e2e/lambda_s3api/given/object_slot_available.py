"""Given: an object slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an object slot is available")
def object_slot_available():
    """No-op: always room for objects."""

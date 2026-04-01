"""Given: a key slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a key slot is available")
def key_slot_available():
    """No-op: always room for cache keys."""

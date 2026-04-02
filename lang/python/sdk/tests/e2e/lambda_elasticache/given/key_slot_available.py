"""Given: an "elasticache" "key" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('an "elasticache" "key" "slot" was "available"')
def key_slot_available():
    """No-op: always room for cache keys."""

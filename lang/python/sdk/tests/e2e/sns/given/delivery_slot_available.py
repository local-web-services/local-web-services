"""Given: a delivery slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a delivery slot is available")
def delivery_slot_available():
    """No-op: always room for deliveries."""

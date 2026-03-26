"""Given: the instance slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the instance slot is available")
def instance_slot_available():
    """No-op: always room for instances."""

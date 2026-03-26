"""Given: the target instance slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the target instance slot is available")
def target_instance_slot_available():
    """No-op: always room for instances."""

"""Given: the resource slot is unallocated"""

from __future__ import annotations

from pytest_bdd import given


@given("the resource slot is unallocated")
def resource_slot_unallocated():
    """No-op: fresh state has no allocated resource slots."""

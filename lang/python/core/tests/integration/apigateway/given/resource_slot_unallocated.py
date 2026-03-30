"""Given: the resource slot is unallocated"""

from __future__ import annotations

from pytest_bdd import given


@given("the resource slot is unallocated")
@given("a resource slot is available")
def resource_slot_unallocated():
    """No-op: fresh state has no allocated resource slots."""

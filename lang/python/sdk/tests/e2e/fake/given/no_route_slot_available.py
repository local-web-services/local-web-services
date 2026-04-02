"""Given: no route slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('no "route" "slot" was "available"')
@given("no route slot is available")
def no_route_slot_available():
    """No-op: fake servers have no maximum route limit; capacity constraint is not enforced."""

"""Given: the event bus has no rules"""

from __future__ import annotations

from pytest_bdd import given


@given("the event bus has no rules")
def bus_has_no_rules():
    """No-op: fresh state for TEST_BUS has no rules."""

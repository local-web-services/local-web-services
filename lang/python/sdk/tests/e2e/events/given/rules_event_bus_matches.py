"""Given: the rule's event bus matches"""

from __future__ import annotations

from pytest_bdd import given


@given("the rule's event bus matches")
def rules_event_bus_matches():
    """No-op: rule was created on the TEST_BUS."""

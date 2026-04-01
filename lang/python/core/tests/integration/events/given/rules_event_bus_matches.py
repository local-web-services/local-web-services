"""Given: the rule's event bus matches."""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule"\'s event eventbridge bus matches')
def rules_event_bus_matches():
    """No-op: rule was created on INT_BUS."""

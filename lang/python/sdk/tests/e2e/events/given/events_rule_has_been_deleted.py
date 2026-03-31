"""Given: an "eventbridge" "rule" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('an "eventbridge" "rule" is deleted')
def events_rule_has_been_deleted():
    """No-op: fresh state has no rules, simulates a previously deleted rule."""

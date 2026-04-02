"""Given: no "eventbridge" "rule" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('no "eventbridge" "rule" was "ENABLED"')
def no_rule_is_enabled():
    """No-op: fresh state has no rules."""

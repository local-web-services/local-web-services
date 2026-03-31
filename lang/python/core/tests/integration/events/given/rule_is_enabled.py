"""Given: the rule is "ENABLED"."""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" was "ENABLED"')
@given('the "eventbridge" "rule" will be "ENABLED"')
def rule_is_enabled_given():
    """No-op: rules are ENABLED by default when created."""

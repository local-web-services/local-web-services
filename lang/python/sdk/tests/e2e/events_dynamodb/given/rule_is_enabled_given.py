"""Given: a "eventbridge" "rule" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" was "ENABLED"')
def rule_is_enabled_given():
    """No-op: rules are ENABLED by default."""

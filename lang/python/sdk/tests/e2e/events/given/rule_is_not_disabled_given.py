"""Given: the rule is not "DISABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('the rule is not "DISABLED"')
def rule_is_not_disabled_given():
    """No-op: newly created rules are ENABLED, not DISABLED."""

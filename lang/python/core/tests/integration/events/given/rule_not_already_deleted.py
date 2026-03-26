"""Given: the rule is not already "DELETED"."""

from __future__ import annotations

from pytest_bdd import given


@given('the rule is not already "DELETED"')
def rule_not_already_deleted_given():
    """No-op: newly created rules are ENABLED, not DELETED."""

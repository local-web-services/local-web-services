"""Given: the "eventbridge" "rule" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" was not "DELETED"')
def rule_is_not_deleted_given():
    """No-op: newly created rules are ENABLED."""

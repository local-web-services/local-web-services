"""Given: the "eventbridge" "rule" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" did not already exist')
def rule_not_already_exist():
    """No-op: fresh state has no rules."""

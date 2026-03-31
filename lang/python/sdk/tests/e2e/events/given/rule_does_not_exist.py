"""Given: the "eventbridge" "rule" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" did not exist')
def rule_does_not_exist():
    """No-op: fresh state has no rules."""

"""Given: the "eventbridge" "rule" has no active targets"""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "rule" has no active targets')
def rule_has_no_active_targets():
    """No-op: newly created rules have no targets."""

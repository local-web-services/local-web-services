"""Given: rule_name not in rule_status"""

from __future__ import annotations

from pytest_bdd import given


@given("rule_name not in rule_status")
def rule_name_not_in_rule_status():
    """No-op: fresh state has no rules."""

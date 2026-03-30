"""Given: the rule does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the rule does not already exist")
def events_lambda_rule_not_already_exist():
    """No-op: fresh state has no rules."""
